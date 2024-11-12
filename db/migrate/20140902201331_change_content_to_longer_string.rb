class ChangeContentToLongerString < ActiveRecord::Migration
  def change
  	change_column :microposts, :content, :string, limit:500
  end
end
