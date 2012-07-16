module UrlHelper

  def post_comments_path(post)
    post_path(post) + "/comments"
  end

  def author_link(comment)
    if comment.author_url.blank?
     comment.author
    else
      link_to(comment.author, comment.author_url, :class => 'openid')
    end
  end
end
