class Category < ActiveRecord::Base

  attr_accessible :name, :categoryable

  default_scope where("categoryable_id is not null and name!='' and categoryable_type is not null")

  
  validates :name, :presence => true

  belongs_to :categoryable, :polymorphic => true
  belongs_to :creator, class_name: 'User'

  has_many :posts

end