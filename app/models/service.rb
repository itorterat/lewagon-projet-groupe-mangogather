class Service < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :category_id, uniqueness: { scope: :user_id }
end
