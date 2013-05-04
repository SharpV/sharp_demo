class AddDowmloadsCountToMedia < ActiveRecord::Migration
  def change
    add_column :media, :downloads_count, :integer, default: 0
  end
end
