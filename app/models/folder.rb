class Folder < ActiveRecord::Base

  default_scope where("user_id is not null")

  belongs_to :user
  
  has_many :media
  
  acts_as_nested_set
  attr_accessible :name, :parent_id, :user_id

  include TheSortableTree::Scopes
  
  def title
    name
  end
      
end
