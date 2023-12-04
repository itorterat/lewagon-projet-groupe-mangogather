class CreateConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :conversations do |t|
      t.references :sender, null: false, foreign_key: { to_table: :users}
      t.references :recipient, null: false, foreign_key: { to_table: :users}

      t.timestamps
    end
  end
end
