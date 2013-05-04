class RenameSharesValueToUsers < ActiveRecord::Migration
  def up
    rename_column :users, :shares_value, :posts_value 
  end

  def down
  end
end
