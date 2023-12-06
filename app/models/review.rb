class Review < ApplicationRecord
  belongs_to :booking
  belongs_to :author, class_name: "User"
end
