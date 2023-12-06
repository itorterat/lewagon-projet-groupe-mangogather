class Booking < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :service
  has_many :reviews, dependent: :destroy

  enum :difficulty, { easy: 0, normal: 1, hard: 2 }, default: :normal
  enum :status, { pending: 0, approved: 1, declined: 2, cancelled: 3 }, default: :pending

  validates :difficulty, inclusion: { in: difficulties.keys }
  validates :status, inclusion: { in: statuses.keys }
end
