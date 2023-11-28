class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :status, { visible: 0, invisible: 1 }, default: :visible

  validates :status, inclusion: { in: statuses.keys }
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
end
