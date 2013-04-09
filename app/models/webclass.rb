 # encoding: utf-8

class Webclass < ActiveRecord::Base
  # attr_accessible :title, :body
  mount_uploader :avatar, ImageUploader

  has_many :members, as: :memberable
  has_many :users, through: :members
  validates :name, :presence => true, :length => {:within => 1..30}
  validates :body, :slug, :presence => true

  mount_uploader :avatar, ImageUploader
    
  has_many :categories, as: :categoryable
  has_many :folders, as: :folderable
  belongs_to :creator, foreign_key: "creator_id", class_name: 'User'
  before_validation :generate_slug

  after_create :create_admin, :create_default_category_and_folder

  private

  def create_default_category_and_folder
    folder = self.folders.build name: '默认目录'
    category = self.categories.build name: '默认分类'
    folder.save and category.save
  end
  
  def generate_slug
    self.slug = Hz2py.do(self.name, :join_with => '-', :to_simplified => true).gsub(/\W/, "-").gsub(/(-){2,}/, '-').to_s
  end
end
