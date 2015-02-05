class Card < ActiveRecord::Base
  validates :original_text, :translated_text, presence: true
  validates :user_id, presence: true
  validate :fields_are_not_equal
  belongs_to :user
  before_create :set_review_date
  mount_uploader :image, ImageUploader
  scope :actual, -> { where("review_date <= ?", Time.now).order("RANDOM()") }

  def correct_answer(translated)
    if translated_text.mb_chars.downcase.strip == translated.mb_chars.downcase.strip
      update_attributes(review_date: Time.now + 3.days)
    else
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
