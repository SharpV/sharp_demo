class Folder < ActiveRecord::Base

  default_scope where("folderable_id is not null and name!='' and folderable_type is not null")


  attr_accessible :name, :folderable

  belongs_to :creator, class_name: 'User'

  belongs_to :folderable, :polymorphic => true
  
  has_many :media

  validates :name, :presence => true
      
end
