class Pack < ActiveRecord::Base
  validates :title, :user_id, presence: true
  validates :title, uniqueness: { scope: :user_id }
  has_many :cards, dependent: :destroy
  belongs_to :user, required: true
  mount_uploader :image, ImageUploader
  after_destroy :reset_current_pack

  def current?
    user.current_pack == self
  end

  def reset_current_pack
    if id == user.current_pack_id
      user.update_attribute(:current_pack_id, nil)
    end
  end
end
