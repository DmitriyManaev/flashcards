module SuperMemo
  def self.call(card, answer_time, answer)
    quality_answer = get_quality_answer(answer_time.to_i, answer)
    e_factor = get_e_factor(card.e_factor, quality_answer)
    interval = number_of_review = 0
    if answer
      number_of_review = card.number_of_review + 1
      if quality_answer >= 4
        interval = get_interval(card.interval_to_review,
                                number_of_review,
                                e_factor)
      end
    end
    card.update_attributes(review_date: Time.now + interval.days,
                           interval_to_review: interval,
                           number_of_review: number_of_review,
                           e_factor: e_factor)
  end

  def self.get_quality_answer(answer_time, answer)
    if answer_time < 7
      quality = 5
    elsif (7..12).include? answer_time
      quality = 4
    else
      quality = 3
    end
    quality -= 3 if !answer
    quality
  end

  # get E-factor SuperMemo2 (step 5) http://www.supermemo.com/english/ol/sm2.htm
  def self.get_e_factor(e_factor, q)
    e_factor += (0.1 - (5 - q) * (0.08 + (5 - q) * 0.02))
    e_factor = 1.3 if e_factor < 1.3
    e_factor = 2.5 if e_factor > 2.5
    e_factor
  end

  def self.get_interval(interval, number_of_review, e_factor)
    case number_of_review
    when 1 then 1
    when 2 then 6
    else interval * e_factor
    end
  end
end
