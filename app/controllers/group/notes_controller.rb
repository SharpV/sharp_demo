#encoding: utf-8
class NotesController < ApplicationController
  
  #before_filter :find_user
    
  set_tab :note, :site_menus, :only => [:index, :show]

  def index
    @notes = current_user.notes.page(params[:page])
    @note_categories = current_user.note_categories.nested_set.all
  end

  def new
    @note = Note.new
  end

  def edit
    @post = Post.find params[:id]
    @user = current_user 
  end

  def show
    @note = Note.find(params[:id])
    #@note.update_attribute :views_count, @note.views_count+1 unless session[:logged_in]
    @comment = Comment.new
    @comments = @note.comments.all#nested_set.all
  end

  def create
    @note = Note.new(params[:note])
    #@note.tag_list = params[:item][:tag].join(",") if params[:item] and params[:item][:tag]
    @note.user = current_user
    respond_to do |format|
      if @note.save 
        format.html  { redirect_to([@note]) }
      else
        format.html  { render :action => "new" }
      end
    end
  end

  def update
    @user = current_user
    if params[:item] and params[:item][:tag]
      params[:post][:tag_list] = params[:item][:tag]
    end
    @post = Post.find(params[:id])
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html  { redirect_to([@user, @post]) }
      else
        format.html { render :action => 'new' }
      end
    end
  end

  # DELETE /my/posts/1
  # DELETE /my/posts/1.json
  def destroy
    @my_post = Post.find(params[:id])
    @my_post.destroy

    respond_to do |format|
      format.html { redirect_to my_posts_url }
      format.json { head :no_content }
    end
  end
end
