class Post < ActiveRecord::Base

  scope :share, where(is_public: true)
  default_scope where("postable_id is not null and slug is not null and postable_type is not null")

  validates :title, :slug, :presence => true

  validates :body, :length => { :minimum => 5 }

  before_validation :generate_slug

  belongs_to :user

  belongs_to :category, foreign_key: :category_id

  has_many :assets, as: :assetable


  paginates_per 30
  
  def to_param
    "#{id}-#{slug.parameterize}"
  end

  def generate_slug
    self.slug = Hz2py.do(self.title, :join_with => '-', :to_simplified => true).gsub(/\W/, "-").gsub(/(-){2,}/, '-').to_s
  end

  def user
    User.find postable_id
  end

  def belongs? actor
    postable_id == actor.id && postable_type == actor.class.to_s.classify
  end

end
