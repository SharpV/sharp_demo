 #encoding: utf-8

class Webclass::MembersController < WebclassController
  respond_to :html, :js
  set_tab :members, :webclass_nav
  set_tab :admin, :webclass_nav, only: [:admin]
  set_tab :members, :webclass_admin_nav, only: [:admin]
  def index
    @members = @current_webclass.members.active
    @students = @members.collect{|m|m.role == 'student'}
    @parents = @members.collect{|m|m.role == 'parent'}
  end 

  def admin
    @members = @current_webclass.members.active.order(:role)
  end

  def update
    @member = Member.find params[:id]
    if @member.update_attributes params[:member]
      render
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
