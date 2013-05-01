class AddLftToGrades < ActiveRecord::Migration
  def change
    add_column :grades, :lft, :integer
    add_column :grades, :rgt, :integer
    add_column :grades, :depth, :integer

    add_column :posts, :grade_id, :integer
    add_column :posts, :subject_id, :integer
    add_column :media, :grade_id, :integer
    add_column :media, :subject_id, :integer
    add_column :questions, :grade_id, :integer
    add_column :questions, :subject_id, :integer

    add_index :posts, :grade_id
    add_index :posts, :subject_id

    add_index :questions, :grade_id
    add_index :questions, :subject_id

    add_index :media, :subject_id
    add_index :media, :grade_id
  end
end
