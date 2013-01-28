class Me::PostsController < MeController
	def index
		@posts = current_user.posts
	end

	def new
		@post = Post::Note.new #{}"Post::#{params[:type].camelize}".constantize.new
		puts Post::Note.all
		@kind = params[:type] || 'note'
	end
end
