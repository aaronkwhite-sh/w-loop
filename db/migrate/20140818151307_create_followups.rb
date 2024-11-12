class CreateFollowups < ActiveRecord::Migration
  def change
    create_table :followups do |t|
      t.integer :user_id
      t.integer :micropost_id

      t.timestamps
    end
    add_index :followups, [:user_id, :created_at]
  end
end
