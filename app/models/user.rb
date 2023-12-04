class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  geocoded_by :city
  after_validation :geocode, if: :will_save_change_to_city?
  has_many :bookings, foreign_key: 'author_id'
  has_many :services
  has_many :categories, through: :services
  accepts_nested_attributes_for :services
  has_one_attached :photo

  enum :status, { visible: 0, invisible: 1 }, default: :visible

  validates :status, inclusion: { in: statuses.keys }
  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  def city_coordinates
    Geocoder.coordinates(self.city)
  end

end
