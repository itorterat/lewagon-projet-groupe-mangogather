class ChangeReviewsAssociation < ActiveRecord::Migration[7.0]
  def change
    remove_reference :reviews, :services, index: true, foreign_key: true
    add_reference :reviews, :booking, null: false, index: true, foreign_key: true
  end
end
