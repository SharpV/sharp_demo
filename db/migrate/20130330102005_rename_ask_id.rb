class RenameAskId < ActiveRecord::Migration
  def up
    rename_column :answers, :answer_id, :question_id
  end

  def down
  end
end
