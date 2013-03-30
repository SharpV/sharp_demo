class Question < ActiveRecord::Base
  acts_as_taggable_on :tags
  make_voteable
  belongs_to :user
  has_many :answers

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
end
