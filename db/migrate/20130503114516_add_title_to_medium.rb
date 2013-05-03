class AddTitleToMedium < ActiveRecord::Migration
  def change
    add_column :images, :title, :string
    add_column :media, :title, :string
  end
end
