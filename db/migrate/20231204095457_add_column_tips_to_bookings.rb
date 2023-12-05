class AddColumnTipsToBookings < ActiveRecord::Migration[7.0]
  def change
    add_column :bookings, :tip, :integer, default: 0
  end
end
