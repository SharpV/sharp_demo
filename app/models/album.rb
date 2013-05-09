#encoding: utf-8

class Album < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :user, counter_cache: true
  belongs_to :group, counter_cache: true
  
  has_many :images

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
