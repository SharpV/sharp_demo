class AddDraftToMessages < ActiveRecord::Migration
  def change
    remove_column :messages, :delete
    add_column :messages, :is_draft, :boolean, default: false
    add_column :messages, :is_delete, :boolean, default: false
  end
end
