class RenameGroupsCountToSchools < ActiveRecord::Migration
  def up
    rename_column :schools, :groups_counter, :groups_count
  end

  def down
  end
end
