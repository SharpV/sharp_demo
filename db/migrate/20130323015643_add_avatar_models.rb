class AddAvatarModels < ActiveRecord::Migration
  def up
    rename_column :groups, :logo, :avatar
    rename_column :courses, :cover, :avatar
  end

  def down
  end
end
