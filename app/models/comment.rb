class Comment < ActiveRecord::Base
 
  validates_presence_of :user_id, :raw_content
  
  acts_as_nested_set
  include TheSortableTree::Scopes
  before_save :prepare_content
  
  belongs_to :user

 

  def trusted_user?
    false
  end

  def user_logged_in?
    false
  end

  # Delegates
  def post_title
    post.title
  end

  class << self
    def protected_attribute?(attribute)
      [:author, :body].include?(attribute.to_sym)
    end

    def new_with_filter(params)
      comment = Comment.new(params)
      comment.created_at = Time.now
      comment.apply_filter
      comment
    end

    def build_for_preview(params)
      comment = Comment.new_with_filter(params)
      if comment.requires_openid_authentication?
        comment.author_url = comment.author
        comment.author     = "Your OpenID Name"
      end
      comment
    end

    def find_recent(options = {})
      find(:all, {
        :limit => DEFAULT_LIMIT,
        :order => 'created_at DESC'
      }.merge(options))
    end
  end
  
  private

   def prepare_content
     # Any content filters here
     self.content = "<b>#{self.raw_content}</b>"
   end
end
