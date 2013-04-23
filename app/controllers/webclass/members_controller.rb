 #encoding: utf-8

class Webclass::MembersController < WebclassController
  respond_to :html, :js
  set_tab :members, :webclass_nav
  set_tab :admin, :webclass_nav, only: [:admin]
  set_tab :members, :webclass_admin_nav, only: [:admin]
  def index
    @members = @current_webclass.members.includes(:user).active.order(:role)
    @students = @members.select{|m|m.role == 'student'}
    @teachers = @members.select{|m|m.role == 'teacher'}
    @parents = @members.select{|m|m.role == 'parent'}
  end 

  def admin
    @members = @current_webclass.members.includes(:user).active.order(:role)
  end

  def set_admin
    @member = Member.find params[:id]
    if @member.admin 
      @member.admin = false
    else
      @member.admin = true
    end
    @member.save
  end

  def new_message
    @member = Member.find(params[:id])
    @message = Message.new 
  end

  def create_message
    @member = Member.find(params[:id])
    send_to_parent = params[:message].delete(:send_to_parent)
    if @member.memberable_id == @current_webclass.id and @member.memberable_type == @current_webclass.class.name
      @message = Message.new params[:message]
      if send_to_parent
        parents = @current_webclass.members.select{|member|member.student_id == @member.id}
        parents.each do |parent| 
          message.sender = current_user
          message.webclass = @current_webclass
          message.recipient_id = parent.user_id
          message.save
        end
      end
      @message.sender = current_user
      @message.webclass = @current_webclass
      @message.recipient_id = @member.user_id
      @message.save
      puts @message.inspect
    end
  end

  def change_role
    @member = Member.find params[:member_id]
    if @member and params[:role] and ['teacher', 'student', 'parent'].include? params[:role]
      @member.role = params[:role]
      @member.save
    end
    #render partial: 'member', member: @member, locals: {member: @member}
  end

  def agree
    @member = Member.find params[:id]
    if @member.memberable_id == @current_webclass.id and @member.memberable_type == @current_webclass.class.name
      @member.active = true
      if @member.save
        @member.user.add_role @member.role, @current_webclass
      end
    end
    @apply_members = @current_webclass.members.apply
  end

  def reject
    @member = Member.find params[:id]
    if @member.memberable_id == @current_webclass.id and @member.memberable_type == @current_webclass.class.name
      @member.destroy
    end
    @apply_members = @current_webclass.members.apply
  end
end
