class Webclass::PostsController < WebclassController
  respond_to :html, :js
  set_tab :posts, :webclass_nav

  def index
  end
end
