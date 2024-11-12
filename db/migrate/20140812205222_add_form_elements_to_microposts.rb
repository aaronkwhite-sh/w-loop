class AddFormElementsToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :typeofcall, :string
    add_column :microposts, :company, :string
    add_column :microposts, :mood, :string
    add_column :microposts, :min, :integer
  end
end
