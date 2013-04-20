class AddMemberIdToExams < ActiveRecord::Migration
  def change
    rename_column :exams, :creator, :creator_id
    add_column :exams, :course_id, :integer
    add_column :reports, :member_id, :integer, null: false
    add_column :members, :student_id, :integer
  end
end
