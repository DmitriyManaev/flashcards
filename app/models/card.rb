class Card < ActiveRecord::Base
  validates :original_text, :translated_text, presence: true
  validates :pack_id, presence: true
  validate :fields_are_not_equal

  belongs_to :pack, required: true
  belongs_to :user

  before_create :set_review_date

  mount_uploader :image, ImageUploader

  scope :actual, -> { where("review_date <= ?", Time.now).order("RANDOM()") }

  INTERVALS_TO_REVIEW = [12.hours, 3.days, 7.days, 14.days, 28.days]

  def correct_answer(translated)
    if Levenshtein.distance(to_same(translated_text), to_same(translated)) <= 2
      self.number_of_review = 4 if number_of_review >= 5
      update_attributes(review_date: Time.now + INTERVALS_TO_REVIEW[number_of_review],
                        number_of_review: number_of_review + 1,
                        failed_attempts: 0)
    else
      self.failed_attempts += 1
      if (1..3).include? failed_attempts
        update_attributes(failed_attempts: failed_attempts)
      else
        update_attributes(review_date: Time.now + INTERVALS_TO_REVIEW[0],
                          number_of_review: 0,
                          failed_attempts: 0)
      end
      return false
    end
  end

  private

  def set_review_date
    self.review_date = Time.now
  end

  def fields_are_not_equal
    if self.original_text == self.translated_text
      errors.add(:base, "Original and translated text cannot be equal.")
    end
  end

  def to_same word
    word.mb_chars.downcase.strip.to_s
  end
end
