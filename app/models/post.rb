class Post < ActiveRecord::Base

  paginates_per 20

  scope :share, where("column_id is not null")

  acts_as_commentable
  acts_as_taggable

  validates :title, :slug, :presence => true

  validates :body, :length => { :minimum => 5 }

  before_validation :generate_slug

  belongs_to :user, counter_cache: true

  belongs_to :category, counter_cache: true

  belongs_to :column, counter_cache: true
  

  def to_param
    slug ? "#{id}-#{slug.parameterize}" : id.to_s
  end

  def generate_slug
    self.slug = Hz2py.do(self.title, :join_with => '-', :to_simplified => true).gsub(/\W/, "-").gsub(/(-){2,}/, '-').to_s
  end

  def belongs? actor
    postable_id == actor.id && postable_type == actor.class.to_s.classify
  end

  class << self
    def top_users 
      @users = User.order("posts_value").limit(10)
    end
  end

end
