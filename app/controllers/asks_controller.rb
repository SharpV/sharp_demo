class AsksController < ApplicationController
     
  before_filter :set_section
  
  before_filter :login_required, :only => [:new, :edit, :create, :update, :destroy]
  
  
  def set_section
    @section = 'FORUM' 
  end
  
  
  def grid_data
    if params[:forum_topic_id]
      @forum_topic = ForumTopic.find(params[:forum_topic_id])
      @forum_posts = @forum_topic.forum_threads
    else
      if current_user
        # just get posts for current user
        @forum_posts = current_user.forum_posts
      end
    end
    respond_to do |format|
      format.xml { render :partial => 'forum_posts/griddata.xml.builder', :layout=>false }
    end
  end
  
  
  def index        
    respond_to do |format|
      format.html {
        if params[:forum_topic_id]
          @forum_topic = ForumTopic.find(params[:forum_topic_id])
          @forum_posts = @forum_topic.forum_threads
        elsif current_user
          # just get posts for current user
          @forum_posts = current_user.forum_posts
        else
          redirect_to(forum_topics_url)
          return
        end
      }
      format.xml  { 
        if params[:forum_topic_id]
          @forum_topic = ForumTopic.find(params[:forum_topic_id])
          @forum_posts = @forum_topic.forum_threads
        elsif params[:user_id] 
          # just get posts for current user
          @forum_posts = current_user.forum_posts
        else
          @forum_posts = ForumPost.find(:all) 
        end
        render :xml => @forum_posts 
      }
      format.json { 
        if params[:forum_topic_id]
          @forum_topic = ForumTopic.find(params[:forum_topic_id])
          @forum_posts = @forum_topic.forum_threads
        elsif params[:user_id] 
          # just get posts for current user
          @forum_posts = current_user.forum_posts
        else
          @forum_posts = ForumPost.find(:all) 
        end
        render :json => @forum_posts 
      } 
    end
  end


  def show
    @forum_post = ForumPost.find(params[:id])
    if @forum_post.parent_id != nil
      @forum_post = ForumPost.find(@forum_post.parent_id)
    end
    @forum_post.update_attributes(:views=>@forum_post.views+1)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @forum_post }
      format.json { render :json => @forum_post } 
    end
  end


  def new
    @forum_post = ForumPost.new
    #@forum_topic_id = params[:forum_topic_id]
    @forum_post.forum_topic_id = params[:forum_topic_id]
   respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @forum_post }
      format.json { render :json => @forum_post } 
    end
  end


  def edit
    @forum_post = ForumPost.find(params[:id])
  end


  def create
    @forum_post = ForumPost.new(params[:forum_post])
    @forum_post.user = current_user;
    respond_to do |format|
      if @forum_post.save
        if params[:ajax_call]
          @forum_post = ForumPost.find(@forum_post.parent_id)
          format.html { render :partial=>'forum_post_replies', :layout=>false }
        else
          flash[:notice] = 'ForumPost was successfully created.'
          format.html { redirect_to(@forum_post) }
          format.xml  { render :xml => @forum_post, :status => :created, :location => @forum_post }
          format.json { render :json => @forum_post, :status => :created, :location => @forum_post } 
        end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @forum_post.errors, :status => :unprocessable_entity }
        format.json { render :json => @forum_post.errors, :status => :unprocessable_entity } 
      end
    end
  end


  def update
    @forum_post = ForumPost.find(params[:id])
    respond_to do |format|
      if @forum_post.update_attributes(params[:forum_post])
        flash[:notice] = 'ForumPost was successfully updated.'
        format.html { redirect_to(@forum_post) }
        format.xml  { head :ok }
        format.json { head :ok } 
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @forum_post.errors, :status => :unprocessable_entity }
        format.json { render :json => @forum_post.errors, :status => :unprocessable_entity } 
      end
    end
  end


  def destroy
    @forum_post = ForumPost.find(params[:id])
    @forum_post.destroy
    respond_to do |format|
      format.html { redirect_to(forum_posts_url) }
      format.xml  { head :ok }
      format.json { head :ok } 
    end
  end
end
