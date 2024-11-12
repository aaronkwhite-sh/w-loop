class CreateMetoos < ActiveRecord::Migration
  def change
    create_table :metoos do |t|
      t.integer :user_id
      t.integer :micropost_id

      t.timestamps
    end
    add_index :metoos, [:user_id, :created_at]
  end
end
