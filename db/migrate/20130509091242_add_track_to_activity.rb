class AddTrackToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :trackable_id, :integer
    add_column :activities, :trackable_type, :string
    add_index :activities, [:trackable_id, :trackable_type]
  end
end
