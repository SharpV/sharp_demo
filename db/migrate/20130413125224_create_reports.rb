class CreateReports < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, default: 'teacher', null: false, limit: 10
    create_table :reports do |t|
      t.integer "course_id",  :null => false
      t.integer "exam_id", :null => false
      t.integer "value"
      t.integer "term_id",    :null => false
      t.integer "webclass_id",    :null => false
      t.timestamps
    end

    add_index :reports, [:webclass_id]
    add_index :reports, [:webclass_id, :term_id]
    add_index :reports, [:term_id]
  end
end
