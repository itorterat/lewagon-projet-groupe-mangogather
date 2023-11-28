class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.integer :difficulty, default: 1
      t.integer :status, default: 0
      t.datetime :date
      t.integer :price
      t.references :author, null: false, foreign_key: { to_table: :users }
      t.references :service, null: false, foreign_key: true

      t.timestamps
    end
  end
end
