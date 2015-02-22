class SuperMemo
  def initialize(card, answer_time, answer)
    @card = card
    @answer_time = answer_time.to_i
    @e_factor = @card.e_factor
    @answer = answer
  end

  def call
    set_quality_answer
    set_e_factor
    @card.number_of_review = @answer ? @card.number_of_review + 1 : 0
    @card.update_attributes(review_date: Time.now + interval.days,
                            interval_to_review: interval,
                            number_of_review: @card.number_of_review,
                            e_factor: @e_factor)
    @answer
  end

  private

  # quality_answer depends on the time of the card verification
  # less then 7 sec - "good", is between 7 and 12 - "normal",
  # more then 12 - "bad"
  # if the answer is incorrect quality_answer is from 0 to 3
  def set_quality_answer
    if @answer_time < 7
      @quality_answer = 5
    elsif (7..12).include? @answer_time
      @quality_answer = 4
    else
      @quality_answer = 3
    end
    @quality_answer -= 3 if !@answer
  end

  # get E-factor SuperMemo2 (step 5) http://www.supermemo.com/english/ol/sm2.htm
  def set_e_factor
    q = @quality_answer
    @e_factor += (0.1 - (5 - q) * (0.08 + (5 - q) * 0.02))
    @e_factor = 1.3 if @e_factor < 1.3
    @e_factor = 2.5 if @e_factor > 2.5
  end

  def interval
    return 0 if @quality_answer < 4 # if "bad" card must be repeated today
    case @card.number_of_review
    when 1 then 1
    when 2 then 6
    else @card.interval_to_review * @e_factor
    end
  end
end
