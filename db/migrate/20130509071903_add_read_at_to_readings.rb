class AddReadAtToReadings < ActiveRecord::Migration
  def change
    add_column :readings, :read_at, :datetime, default: Time.now
  end
end
