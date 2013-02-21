class AddTypeToPost < ActiveRecord::Migration
  def change
    add_column "posts", :postable_id, :integer
    add_column "posts", :postable_type, :string
    add_column "posts", :slug, :string
    remove_column "posts", :user_id
  end
end
