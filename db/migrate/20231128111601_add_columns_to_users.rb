class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :balance, :integer, default: 100
    add_column :users, :description, :text
    add_column :users, :status, :integer, default: 0
    add_column :users, :city, :string
  end
end
