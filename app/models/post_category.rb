class PostCategory < ActiveRecord::Base
  acts_as_nested_set
  include TheSortableTree::Scopes
  attr_accessible :name, :parent_id, :lft, :rgt, :depth
  
  belongs_to :user

  has_many :posts


  def title
    name
  end

end