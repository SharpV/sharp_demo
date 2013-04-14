class AddRoleToMember < ActiveRecord::Migration
  def change
    drop_table :assets

    add_column :members, :role, :string, limit: 10, null: false, default: 'teacher'
  end
end
