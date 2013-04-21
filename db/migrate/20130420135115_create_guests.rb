class CreateGuests < ActiveRecord::Migration
  def change
    create_table "guests", :force => true do |t|
      t.integer "user_id"
      t.timestamps
      t.integer "guestable_id"
      t.string  "guestable_type"
    end
    add_index :guests, :user_id
    add_index :guests, [:guestable_type, :guestable_id]
  end
end
