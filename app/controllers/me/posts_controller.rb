class Me::PostsController < MeController
	def index
		@posts = current_user.posts
	end
end
