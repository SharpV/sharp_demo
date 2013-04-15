 #encoding: utf-8
require 'ostruct'
class Webclass::MessagesController < WebclassController
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
      puts group.inspect
    end
  end

  def sendout
    @messages = Message.webclass.where(sender_id: current_user.id).page params[:page]
  end

  def show
    @message = Message.find params[:id]
    unless @message.sender_id == current_user.id or @message.recipient_id == current_user.id 
      redirect_to [:webclass, @current_webclass, 'messages']
    end
  end

  def create
    message = Message.new params[:message]
    message.sender = current_user
    message.webclass = @current_webclass
    if  message.save
      redirect_to [:webclass, @current_webclass, 'messages']
    else
      render action: :new
    end
  end
end
