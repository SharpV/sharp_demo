class CreateMeDocuments < ActiveRecord::Migration
  def change
    create_table :me_documents do |t|

      t.timestamps
    end
  end
end
