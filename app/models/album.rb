class Album < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :creator, class_name: 'User'

  belongs_to :albumable, :polymorphic => true
  
  has_many :images, as: :imageable

  belongs_to :image

  validates :name, :presence => true


  def avatar
    if image 
      image.avatar 
    elsif images.first
     images.first.file
    end
  end
end
