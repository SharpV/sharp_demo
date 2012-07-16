class CommentsController < ApplicationController
  include TheSortableTreeController::Rebuild

  def index
    @comments = Comment.nested_set.all
  end

  def manage
    @comments = Comment.nested_set.all
  end

  def comments
    @comments = Comment.nested_set.all
  end

  def create
    @comment = Comment.new params[:comment]
    @comment.user = current_user
    @comment.name = current_user.login
    @comment.save!
    redirect_to(request.referer || '/')
  end
end
