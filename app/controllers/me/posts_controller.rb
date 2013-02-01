class Me::PostsController < MeController
	def index
		@posts = current_user.posts
		respond_to do |format|
    		format.html  # index.html.erb
   	 		format.json  { render :json => @posts }
   	 	end
	end

	def new
		@post = "Post::#{params[:type].camelize}".constantize.new
		puts Post::Note.all
		@kind = params[:type] || 'note'
	end

	def create
		@post = "Post::#{params[:type].camelize}".constantize.new params["post_#{params[:type]}"]
 		@post.user = current_user
 		@post.kind = params[:type]
  		respond_to do |format|
    		if @post.save
      			format.html  { redirect_to(me_post_path(@post), :notice => 'Post was successfully created.') }
      			format.json  { render :json => @post,
                    :status => :created, :location => @post }
    		else
      			format.html  { render :action => "new" }
      			format.json  { render :json => @post.errors,
                    :status => :unprocessable_entity }
    		end
  		end
	end

	def show
  		@post = Post.find(params[:id])
 
  		respond_to do |format|
    		format.html  # show.html.erb
   			format.json  { render :json => @post }	
   		end
	end

	def update
  		@post = Post.find(params[:id])
 
  		respond_to do |format|
    		if @post.update_attributes(params[:post])
      			format.html  { redirect_to(@post,
                    :notice => 'Post was successfully updated.') }
      			format.json  { head :no_content }
    		else
      			format.html  { render :action => "edit" }
      			format.json  { render :json => @post.errors,
                    :status => :unprocessable_entity }
    		end
  		end
	end

	def destroy
  		@post = Post.find(params[:id])
  		@post.destroy
 
  		respond_to do |format|
    		format.html { redirect_to posts_url }
    		format.json { head :no_content }
  		end
	end
end
