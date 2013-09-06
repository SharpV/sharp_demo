class AddAdditionalInfo < ActiveRecord::Migration
  def up
    add_column :products, :additional_info, :string
  end

  def down
  end
end
