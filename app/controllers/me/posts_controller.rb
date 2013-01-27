class Me::PostsController < MeController
	def index
		@posts = current_user.posts
	end

	def new
		@post = Post.new
		@kind = params[:type] || 'note'
	end
end
