class NoteCategory < ActiveRecord::Base
  belongs_to :user
  has_many :notes
  
  acts_as_nested_set
  attr_accessible :name, :parent_id, :user
  include TheSortableTree::Scopes
  
  def title
    name
  end
end
