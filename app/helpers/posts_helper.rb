module PostsHelper
  
protected
  
  def post_markup(text)
    html = Markdown.markdown(text)
    replaceable = Replaceable.new(html)
    replaceable.replace(:gists, :tags, :usernames, :emoji)
    replaceable.to_s.html_safe
  end
end
