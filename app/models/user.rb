class User < ActiveRecord::Base
  validates :password, length: { minimum: 6 }
  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :authentications, dependent: :destroy
  has_many :packs, dependent: :destroy
  has_many :cards, through: :packs
  belongs_to :current_pack, class_name: "Pack"

  authenticates_with_sorcery!
  accepts_nested_attributes_for :authentications

  def card_for_review
    if current_pack
      current_pack.cards.actual.first
    else
      cards.actual.first
    end
  end
end
