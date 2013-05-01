class CreateColumns < ActiveRecord::Migration
  def change
    create_table :columns do |t|
      t.string  "name"
      t.string  "column_type"
      t.integer "parent_id"
      t.integer "location",   :default => 0
      t.integer "posts_count",       :default => 0
      t.timestamps
    end

  end
end
