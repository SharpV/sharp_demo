class Post < ActiveRecord::Base

  default_scope where("postable_id is not null and slug is not null and postable_type is not null")

  validates :title, :body, :slug, :presence => true

  scope :share, where(:postable_type => 'User')

  before_validation :generate_slug

  belongs_to :postable, :polymorphic => true
  
  def to_param
    "#{id}-#{slug.parameterize}"
  end

  def generate_slug
    self.slug = Hz2py.do(self.title, :join_with => '-', :to_simplified => true).gsub(/\W/, "-").gsub(/(-){2,}/, '-').to_s
  end

  def user
    User.find postable_id
  end
end
