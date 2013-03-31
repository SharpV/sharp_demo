class Folder < ActiveRecord::Base

  attr_accessible :name, :folderable

  belongs_to :creator, class_name: 'User'

  belongs_to :folderable, :polymorphic => true
  
  has_many :media

  validates :name, :presence => true
      
end
