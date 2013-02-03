class CreateMeNotes < ActiveRecord::Migration
  def change
    create_table :me_notes do |t|

      t.timestamps
    end
  end
end
