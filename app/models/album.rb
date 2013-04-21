class Album < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :creator, class_name: 'User'

  belongs_to :albumable, :polymorphic => true
  
  has_many :images, as: :imageable

  validates :name, :presence => true

end
