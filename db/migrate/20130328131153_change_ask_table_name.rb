class ChangeAskTableName < ActiveRecord::Migration
  def up
    rename_table :asks, :questions
  end

  def down
  end
end
