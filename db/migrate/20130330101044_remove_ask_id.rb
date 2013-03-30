class RemoveAskId < ActiveRecord::Migration
  def up
    rename_column :answers, :ask_id, :answer_id
  end

  def down
  end
end
