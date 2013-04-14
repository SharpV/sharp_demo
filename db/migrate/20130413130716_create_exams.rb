class CreateExams < ActiveRecord::Migration
  def change
    drop_table :courses_members
    drop_table :properties
    create_table :exams do |t|
      t.string "title",  :null => false
      t.text "body"
      t.datetime "start_at"
      t.datetime "end_at"
      t.integer "webclass_id",       :null => false
      t.integer "term_id",    :null => false
      t.integer "creator",    :null => false
      t.timestamps
    end
    add_index :exams, [:webclass_id]
    add_index :exams, [:webclass_id, :term_id]
    add_index :exams, [:term_id]
  end
end
