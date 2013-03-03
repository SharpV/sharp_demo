class Category < ActiveRecord::Base
  acts_as_nested_set
  include TheSortableTree::Scopes
  attr_accessible :name, :parent_id
  
  belongs_to :categoryable, polymorphic: true


  def title
    name
  end

end