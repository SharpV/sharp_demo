 # encoding: utf-8

class Webclass < ActiveRecord::Base
  # attr_accessible :title, :body
  mount_uploader :avatar, ImageUploader

  has_many :members, as: :memberable
  has_many :users, through: :members
  validates :name, :presence => true, :length => {:within => 1..30}
  validates :body, :slug, :presence => true

  mount_uploader :avatar, ImageUploader
  has_many :terms
  has_many :slots
  has_many :categories, as: :categoryable
  has_many :folders, as: :folderable
  belongs_to :creator, foreign_key: "creator_id", class_name: 'User'
  before_validation :generate_slug

  after_create :create_admin, :create_default_category_and_folder, :current_term

  def current_term
    if Date.current > Date.new(Time.now.year, 3, 1) and Date.current <= Date.new(Time.now.year, 8, 1)
      find_or_create_current_term(Time.now.year, 0)
    elsif Date.current > Date.new(Time.now.year, 8, 1) and Date.current <= Date.new(Time.now.year, 12, 31)
      find_or_create_current_term(Time.now.year, 1)
    else
      find_or_create_current_term(Time.now.year-1, 1)
    end
  end

  private

  def find_or_create_current_term(year, part)
    terms.where(year:Time.now.year, part:0).first || Term.create(webclass: self, year: year, part: 0, creator: self.creator)
  end


  def create_default_category_and_folder
    folder = self.folders.build name: '默认目录'
    category = self.categories.build name: '默认分类'
    folder.save and category.save
  end

  def create_admin
    Member.create memberable: self, user: self.creator, admin: true, active: true
  end
  
  def generate_slug
    self.slug = Hz2py.do(self.name, :join_with => '-', :to_simplified => true).gsub(/\W/, "-").gsub(/(-){2,}/, '-').to_s
  end
end
