class Folder < ActiveRecord::Base

  attr_accessible :name

  belongs_to :creator, class_name: 'User'

  belongs_to :categoryable, :polymorphic => true
  
  has_many :media

  validates :name, :presence => true
      
end
