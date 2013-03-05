class RenameMedias < ActiveRecord::Migration
  def up
    rename_table :medias, :media
  end

  def down
  end
end
