class Card < ActiveRecord::Base
  validates :original_text, :translated_text, presence: true
  validates :pack_id, presence: true
  validate :fields_are_not_equal

  belongs_to :pack, required: true
  belongs_to :user

  before_create :set_review_date

  mount_uploader :image, ImageUploader

  scope :actual, -> { where("review_date <= ?", Time.now).order("RANDOM()") }

  ADDED_TIME = [12.hours, 3.days, 7.days, 14.days, 28.days]

  def correct_answer(translated)
    if translated_text.mb_chars.downcase.strip == translated.mb_chars.downcase.strip
      update_attributes(review_date: Time.now + ADDED_TIME[check_number],
                        check_number: check_number + 1,
                        fail_check: 0)
    else
      self.fail_check += 1
      if (1..3).include? fail_check
        update_attributes(fail_check: fail_check)
      else
        update_attributes(review_date: Time.now + ADDED_TIME[0],
                          check_number: 0,
                          fail_check: 0)
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
end
