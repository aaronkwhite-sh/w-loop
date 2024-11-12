class ChangeAreaofappToArray < ActiveRecord::Migration
  def change
  	add_column :microposts, :areaofapparray, :string, array: true, default: []
  end
end
