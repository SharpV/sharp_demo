 #encoding: utf-8

class User::MessagesController < UserController
  respond_to :html, :js
  set_tab :messages, :user_nav
  set_tab :sendout, :messages_nav, only: [:sendout]
  set_tab :index, :messages_nav, only: [:index]
  set_tab :write, :messages_nav, only: [:new]
  
  def index
    @messages = Message.user.where(recipient_id: current_user.id).page params[:page]
  end 

  def new
    @message = Message.new
  end

  def sendout
    @messages = Message.user.where(sender_id: current_user.id).page params[:page]
  end

  def show
    @message = Message.find params[:id]
    @message.update_attributes read: true
    @replies = @message.replies
    if @message.sender_id == current_user.id
      set_tab :sendout, :messages_nav
    else
      set_tab :index, :messages_nav
    end
      
    unless @message.sender_id == current_user.id or @message.recipient_id == current_user.id 
      redirect_to root_path
    end
  end

  def reply
    @message = Message.new params[:message]
    @message.sender = current_user
    @message.save
  end

  def create
    recipient_ids = params[:message].delete :recipient_id
    recipient_ids.each do |recipient_id|  
      message = Message.new params[:message]
      message.sender = current_user
      message.recipient_id = recipient_id
      message.save
    end
    redirect_to [@current_namespace, :messages].flatten
  end
  
end
