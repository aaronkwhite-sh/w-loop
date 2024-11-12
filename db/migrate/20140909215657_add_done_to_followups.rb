class AddDoneToFollowups < ActiveRecord::Migration
  def change
    add_column :followups, :done, :boolean, :default => nil
  end
end
