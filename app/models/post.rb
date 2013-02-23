class Post < ActiveRecord::Base

  default_scope where("postable_id is not null and slug is not null and postable_type is not null")

  validates :title, :body, :slug, :presence => true


  before_validation :generate_slug

  belongs_to :postable, :polymorphic => true
  
  def to_param
    "#{id}-#{url.parameterize}"
  end

  def generate_slug
    self.url = Hz2py.do(self.title, :join_with => '-', :to_simplified => true).gsub(/\W/, "-").gsub(/(-){2,}/, '-').to_s
  end
end
