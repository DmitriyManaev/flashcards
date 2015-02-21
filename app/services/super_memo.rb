class SuperMemo
  def initialize(card, answer_time, answer)
    @card = card
    @answer_time = answer_time.to_i
    @interval = @number_of_review = 0
    @e_factor = @card.e_factor
    @answer = answer
  end

  def call
    get_quality_answer
    get_e_factor
    if @answer
      @number_of_review += 1
      get_interval if @quality_answer >= 4
    end
    @card.update_attributes(review_date: Time.now + @interval.days,
                            interval_to_review: @interval,
                            number_of_review: @number_of_review,
                            e_factor: @e_factor)
  end

  private

  def get_quality_answer
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
  def get_e_factor
    @e_factor += (0.1 - (5 - @quality_answer) * (0.08 + (5 - @quality_answer) * 0.02))
    @e_factor = 1.3 if @e_factor < 1.3
    @e_factor = 2.5 if @e_factor > 2.5
  end

  def get_interval
    @interval = case @number_of_review
                when 1 then 1
                when 2 then 6
                else @card.interval_to_review * @e_factor
                end
  end
end
