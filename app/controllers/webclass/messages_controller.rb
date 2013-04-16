 #encoding: utf-8
require 'ostruct'
class Webclass::MessagesController < WebclassController
  respond_to :html, :js
  set_tab :messages, :webclass_nav
  set_tab :sendout, :webclass_messages_nav, only: [:sendout]
  set_tab :index, :webclass_messages_nav, only: [:index]
  def index
    @messages = Message.webclass.where(recipient_id: current_user.id).page params[:page]
  end 

  def new
    @message = Message.new
    @group_members = [] 
    {teacher: '老师', parent: '家长', student: '学生'}.each do |role, role_name|
      group = OpenStruct.new
      group.name = role_name
      group.members = @current_webclass.group_members(role)
      @group_members << group
    end
  end

  def sendout
    @messages = Message.webclass.where(sender_id: current_user.id).page params[:page]
  end

  def show
    @message = Message.find params[:id]
    @replies = @message.replies
    if @message.sender_id == current_user.id
      set_tab :sendout, :webclass_messages_nav
    else
      set_tab :index, :webclass_messages_nav
    end
      
    unless @message.sender_id == current_user.id or @message.recipient_id == current_user.id 
      redirect_to [:webclass, @current_webclass, 'messages']
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
      message.webclass = @current_webclass
      message.recipient_id = recipient_id
      message.save
    end
    redirect_to [:webclass, @current_webclass, :messages]
  end
end
