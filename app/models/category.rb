class Category < ActiveRecord::Base
  include TheSortableTree::Scopes
  attr_accessible :name, :parent_id
  
  belongs_to :categoryable, polymorphic: true


  def title
    name
  end

end