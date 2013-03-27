class Category < ActiveRecord::Base
  attr_accessible :name
  
  validates :name, :presence => true

  belongs_to :categoryable, :polymorphic => true
  belongs_to :creator, class_name: 'User'

  has_many :posts


  def title
    name
  end

end