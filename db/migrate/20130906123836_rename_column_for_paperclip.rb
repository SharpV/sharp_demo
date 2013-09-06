class RenameColumnForPaperclip < ActiveRecord::Migration
  def up
    add_attachment :product_images, :image
    add_attachment :product_manuals, :cover
    add_attachment :product_manuals, :file
  end

  def down
  end
end
