class RenameGrades < ActiveRecord::Migration
  def up
    drop_table :school_grades
    drop_table :columns
    drop_table :shares
    drop_table :bookmarks

    create_table :grades do |t|
      t.string  "name"
      t.integer "parent_id"
      t.integer "location",   :default => 0
      t.integer "posts_count",       :default => 0
      t.integer "media_count",       :default => 0
      t.integer "questions_count",       :default => 0
    end

    add_index :grades, :parent_id

    create_table :subjects do |t|
      t.string  "name"
      t.integer "grade_id"
      t.integer "location",   :default => 0
      t.integer "posts_count",       :default => 0
      t.integer "media_count",       :default => 0
      t.integer "questions_count",       :default => 0
    end

    add_index :subjects, :grade_id
  end

  def down
  end
end
