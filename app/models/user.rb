class User < ActiveRecord::Base
  with_options if: :new_user? do |new_user|
    new_user.validates :password, length: { minimum: 6 }
    new_user.validates :password, confirmation: true
    new_user.validates :password_confirmation, presence: true
    new_user.validates :email, presence: true, uniqueness: true
  end
  has_many :authentications, dependent: :destroy
  has_many :packs, dependent: :destroy
  belongs_to :current_pack, class_name: "Pack"
  authenticates_with_sorcery!
  accepts_nested_attributes_for :authentications

  private

  def new_user?
    new_record?
  end
end
