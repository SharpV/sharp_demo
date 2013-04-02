class AddCreatorIdToPosts < ActiveRecord::Migration
  def change
    Post.delete_all
    add_column :posts, :creator_id, :integer, null: false
  end
end
