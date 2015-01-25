class Card < ActiveRecord::Base
  validates :original_text, :translated_text, presence: true, uniqueness: true
  validate :fields_are_not_equal
  before_create :set_review_date

  def self.actual
    where 'review_date <= ?', Time.now
  end

  def self.random
    order "RANDOM()"
  end

  def correct_answer(translated)
    if self.translated_text == translated
      self.review_date = Time.now + 3.days
      self.save
      true
    end
  end

  private
    def set_review_date
      self.review_date = Time.now
    end

    def fields_are_not_equal
      self.errors.add(:base, 'Original text and translated text cannot be equal.') if self.original_text == self.translated_text
    end
end
