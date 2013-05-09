class RenameImageable < ActiveRecord::Migration
  def up
    add_column :images, :album_id, :integer
    add_index :images, :album_id
  end

  def down
  end
end
