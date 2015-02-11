class Pack < ActiveRecord::Base
  validates :title, :user_id, presence: true
  validates_uniqueness_of :title, scope: :user_id, on: :create
  has_many :cards, dependent: :destroy
  belongs_to :user, required: true
  mount_uploader :image, ImageUploader
  after_destroy :reset_current_pack

  def current?
    self.user.current_pack == self
  end

  def reset_current_pack
    if self.id == self.user.current_pack_id
      self.user.update_attribute(:current_pack_id, nil)
    end
  end
end
