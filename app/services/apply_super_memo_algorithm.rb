class ApplySuperMemoAlgorithm
  def self.call(card, time_answer, answer)
    quality_answer = get_quality_answer(time_answer.to_i)
    quality_answer -= 3 if !answer
    e_factor = get_e_factor(card.e_factor, quality_answer)
    if answer
      interval = 0
      if quality_answer >= 4
        interval = get_interval(card.interval_to_review,
                                card.number_of_review + 1,
                                e_factor)
      end
      update_card(card, interval, card.number_of_review + 1, e_factor)
    else
      update_card(card, 0, 0, e_factor)
    end
  end

  def self.update_card(card, interval, number_of_review, e_factor)
    card.update_attributes(review_date: Time.now + interval.days,
                           interval_to_review: interval,
                           number_of_review: number_of_review,
                           e_factor: e_factor)
  end

  def self.get_quality_answer(time_answer)
    if time_answer < 7
      5
    elsif (7..12).include? time_answer
      4
    else
      3
    end
  end

  def self.get_e_factor(e_factor, q)
    e_factor += (0.1 - (5 - q) * (0.08 + (5 - q) * 0.02))
    e_factor = 1.3 if e_factor < 1.3
    e_factor = 2.5 if e_factor > 2.5
    return e_factor
  end

  def self.get_interval(interval, number_of_review, e_factor)
    case number_of_review
    when 1 then 1
    when 2 then 6
    else interval * e_factor
    end
  end
end
