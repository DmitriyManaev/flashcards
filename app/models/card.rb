class Card < ActiveRecord::Base
  validates :original_text, :translated_text, presence: true, uniqueness: true
  validate :fields_are_not_equal
  before_create :set_review_date
  scope :actual, -> { where('review_date <= ?', Time.now).order("RANDOM()").first }

  private
    def set_review_date
      self.review_date = Time.now
    end

    def fields_are_not_equal
      self.errors.add(:base, 'Original text and translated text cannot be equal.') if self.original_text == self.translated_text
    end
end
