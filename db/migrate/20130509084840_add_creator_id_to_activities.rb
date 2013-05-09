class AddCreatorIdToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :creator_id, :integer, null: false

    add_index :activities, :creator_id
  end
end
