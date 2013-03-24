class AddPositionToSectionsAndSlots < ActiveRecord::Migration
  def change
    add_column :slots, :position, :integer
  end
end
