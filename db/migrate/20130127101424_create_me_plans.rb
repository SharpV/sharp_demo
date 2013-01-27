class CreateMePlans < ActiveRecord::Migration
  def change
    create_table :me_plans do |t|

      t.timestamps
    end
  end
end
