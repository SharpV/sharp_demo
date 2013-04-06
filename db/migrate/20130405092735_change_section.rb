class ChangeSection < ActiveRecord::Migration
  def up
    change_table :sections do |t|
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth # this is optional.
    end
  end

  def down
  end
end
