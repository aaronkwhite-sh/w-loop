class AddAreaofappToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :areaofapp, :string
  end
end
