class RenamePositionToGrades < ActiveRecord::Migration
  def up
    rename_column :grades, :location, :position
    rename_column :subjects, :location, :position
  end

  def down
  end
end
