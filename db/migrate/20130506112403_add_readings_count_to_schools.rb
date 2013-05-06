class AddReadingsCountToSchools < ActiveRecord::Migration
  def change
    add_column :schools, :readings_count, :integer, default: 0
  end
end
