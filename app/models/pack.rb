class Pack < ActiveRecord::Base
  validates :title, :user_id, presence: true
  validates_uniqueness_of :title, scope: :user_id, on: :create
  has_many :cards, dependent: :destroy
  belongs_to :user, required: true
  mount_uploader :image, ImageUploader
  def self.current
    where(current: true).first
  end
end
