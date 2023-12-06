class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :author, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates :content, presence: true
end
