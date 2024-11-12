class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :micropost_id

      t.timestamps
    end
    add_index :favorites, [:user_id, :created_at]
  end
end
