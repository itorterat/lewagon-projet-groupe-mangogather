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
  has_many :sent_conversations, foreign_key: :sender_id, class_name: 'Conversation'
  has_many :received_conversations, foreign_key: :recipient_id, class_name: 'Conversation'
  has_many :messages, through: :conversations

  enum :status, { visible: 0, invisible: 1 }, default: :visible

  validates :status, inclusion: { in: statuses.keys }
  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  def conversations
    Conversation.where("sender_id = ? OR recipient_id = ?", id, id)
  end

  def messages
    Message.where(conversation: conversations)
  end
end
