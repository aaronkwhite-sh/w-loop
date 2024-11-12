class AddCompaniesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :companies, :string, array: true, default: '{}'
  end
end
