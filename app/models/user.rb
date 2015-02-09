class User < ActiveRecord::Base
  validates :password, length: { minimum: 6 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: true
  has_many :authentications, dependent: :destroy
  has_many :packs, dependent: :destroy
  authenticates_with_sorcery!
  accepts_nested_attributes_for :authentications
end
