class Service < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :bookings

  validates :category_id, uniqueness: { scope: :user_id }
end
