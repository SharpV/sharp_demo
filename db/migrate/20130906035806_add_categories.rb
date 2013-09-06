class AddCategories < ActiveRecord::Migration
  def up
    create_table "categories", :force => true do |t|
      t.string  "name"
      t.string  "categoryable_type"
      t.integer "categoryable_id"
      t.integer "creator_id"
      t.integer "posts_count",       :default => 0  
    end 
  end

  def down
  end
end
