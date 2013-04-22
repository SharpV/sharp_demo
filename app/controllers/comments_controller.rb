class CommentsController < ApplicationController
  respond_to :html, :js

  def create
    if ['Post', 'Image', 'Medium'].include? params[:comment][:commentable_type]
      @comment = Comment.new params[:comment]
      @comment.user = current_user
      if @comment.save

      else

      end
    end
  end
end
