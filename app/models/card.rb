class Card < ActiveRecord::Base
  require "card_ext/super_memo"
  include SuperMemo
  validates :original_text, :translated_text, presence: true
  validates :pack_id, presence: true
  validate :fields_are_not_equal

  belongs_to :pack, required: true
  belongs_to :user

  before_create :set_review_date

  mount_uploader :image, ImageUploader

  scope :actual, -> { where("review_date <= ?", Time.now).order("RANDOM()") }

  def correct_answer(translated, answer_time)
    if Levenshtein.distance(sanitize(translated_text), sanitize(translated)) <= 2
      apply_super_memo(answer_time, true)
    else
      apply_super_memo(answer_time, false)
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

  def sanitize(word)
    word.mb_chars.downcase.strip.to_s
  end
end
