class Question < ActiveRecord::Base

  paginates_per 20

  acts_as_taggable_on :tags
  make_voteable

  default_scope  { order('created_at DESC') }

  scope :share, where("grade_id is not null")

  belongs_to :user
  has_many :answers

  belongs_to :grade

  belongs_to :subject

  validates :title, :slug, :presence => true

  validates :body, :length => { :minimum => 10 }

  before_validation :generate_slug

  def to_param
    slug ? "#{id}-#{slug.parameterize}" : id.to_s
  end

  private
  def generate_slug
    self.slug = Hz2py.do(self.title, :join_with => '-', :to_simplified => true).gsub(/\W/, "-").gsub(/(-){2,}/, '-').to_s
  end

  class << self
    def top_users 
      @users = User.order("questions_value").limit(10)
    end
  end
end
