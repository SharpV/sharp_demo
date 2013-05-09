#encoding: utf-8

class Folder < ActiveRecord::Base

  attr_accessible :name

  belongs_to :creator, class_name: 'User'
  
  has_many :media

  validates :name, :presence => true
      
end
