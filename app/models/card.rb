class Card < ActiveRecord::Base
  validates :original_text, :translated_text, presence: true
  before_save :get_review_date

  private
    def get_review_date
      self.review_date = Time.now
    end
end
