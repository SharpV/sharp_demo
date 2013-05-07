class AddColumns < ActiveRecord::Migration
  def up

    create_table "columns", :force => true do |t|
      t.string   "name", limit: 30
      t.datetime "created_at", :null => false
      t.integer "media_count", :default => 0
      t.integer  "posts_count", :default => 0
      t.integer :position, :default => 0
    end

    remove_column :posts, :grade_id
    remove_column :posts, :subject_id

    add_column :posts, :column_id, :integer
    add_index :posts, :column_id

    remove_column :media, :grade_id
    remove_column :media, :subject_id

    add_column :media, :column_id, :integer
    add_index :media, :column_id
  end

  def down
  end
end
