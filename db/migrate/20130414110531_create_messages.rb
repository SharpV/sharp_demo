class CreateMessages < ActiveRecord::Migration
  def change
    drop_table :group_topics
    create_table :messages do |t|
      t.text     "body"
      t.string   "title", :null => false
      t.boolean   "delete", default: false
      t.datetime "send_at"
      t.integer  "member_id"
      t.integer  "recipient_id"
      t.boolean  "read",                       :default => false
      t.integer  "sender_id",                  :null => false
      t.timestamps
    end

    add_index :messages, :sender_id
    add_index :messages, :recipient_id
    add_index :messages, :member_id
  end
end
