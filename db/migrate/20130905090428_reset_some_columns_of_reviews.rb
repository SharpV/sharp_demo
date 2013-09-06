class ResetSomeColumnsOfReviews < ActiveRecord::Migration
  def up
    add_column :reviews, :city, :string
    add_column :reviews, :author, :string
    add_column :reviews, :star, :float
    remove_column :reviews, :user_id
  end

  def down
    remove_column :reviews, :city
    remove_column :reviews, :author
    remove_column :reviews, :star
  end
end
