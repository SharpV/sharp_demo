class AddQuestionValueToUsers < ActiveRecord::Migration
  def change
    rename_column :users, :up_votes, :questions_value
    rename_column :users, :down_votes, :shares_value
    add_column :users, :media_value, :integer, default: 0

    create_table "consumes", :force => true do |t|
      t.string   "value_type", :null => false
      t.integer  "user_id", :null => false
      t.integer   "value", :null => false
      t.datetime "created_at",    :null => false
    end

    add_index :consumes, :user_id

    create_table "readings", :force => true do |t|
      t.integer  "readable_id",   :null => false
      t.string   "readable_type", :null => false
      t.integer  "user_id"
      t.datetime "created_at",    :null => false
    end

    add_index :readings, [:readable_id, :readable_type]

  end
end
