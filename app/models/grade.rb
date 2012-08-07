class Grade < ActiveRecord::Base
  scope :list, where(:parent_id => nil)
  #scope :grades, where(:parent_id => self.id)
  
  
  acts_as_nested_set
  attr_accessible :name, :parent_id, :parent
  
  has_many :subjects
  has_many :groups
end