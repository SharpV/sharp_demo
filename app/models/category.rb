#encoding: utf-8

class Category < ActiveRecord::Base

  attr_accessible :name
  
  validates :name, :presence => true

  acts_as_nested_set

end