class AddCourseIdToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :course_id, :integer
    add_column :assignments, :term_id, :integer, null: false
    remove_column :assignments, :admin
  end
end
