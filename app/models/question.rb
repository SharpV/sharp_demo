class Question < ActiveRecord::Base

  has_many :answers, :dependent => :destroy
  belongs_to :user

  #validates :title, :presence => true
  #validates :slug, :presence => true, :uniqueness => true
  
  scope :not_answered, where(:answers_count => 0)
  scope :answers, where("user_id != null")

  before_validation :generate_slug
  after_destroy :expire_user_cache

  acts_as_taggable

  def login
    user.login
  end

  def tweet_path
    "questions/#{to_param}"
  end

  def to_param
    "#{id}-#{slug.parameterize}"
  end

  protected
  def generate_slug
    self.slug = Hz2py.do(self.title, :join_with => '-', :to_simplified => true).gsub(/\W/, "-").gsub(/(-){2,}/, '-').to_s
    return true
  end
end

