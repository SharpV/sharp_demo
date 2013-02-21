require 'pathname'
require 'carrierwave/orm/activerecord'

class Group < ActiveRecord::Base

  mount_uploader :logo, ImageUploader
  
  belongs_to :user, :foreign_key => "creator_id"
  
  belongs_to :grade
  
  has_many :topics
  has_many :categories
  has_many :questions
  
  before_validation :generate_slug

  def to_param
    "#{id}-#{slug.parameterize}"
  end

  private
  
  
  def generate_slug
    self.slug = Hz2py.do(self.name, :join_with => '-', :to_simplified => true).gsub(/\W/, "-").gsub(/(-){2,}/, '-').to_s
  end
end
