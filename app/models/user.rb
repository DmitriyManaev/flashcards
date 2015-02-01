class User < ActiveRecord::Base
  authenticates_with_sorcery!
  has_many :authentications, dependent: :destroy
  accepts_nested_attributes_for :authentications
  validates :password, length: { minimum: 6 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: true
  has_many  :cards, dependent: :destroy
end
