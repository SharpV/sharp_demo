class Webclass::MessagesController < WebclassController
  set_tab :messages, :webclass_nav
  set_tab :admin, :webclass_nav, only: [:admin]
  def index
    @members = @current_webclass.members.active
    @students = @members.collect{|m|m.role == 'student'}
    @parents = @members.collect{|m|m.role == 'parent'}
  end 

  def new
    @message = Message.new
  end
end
