class Group::ExamsController < GroupController
  respond_to :html, :js
  set_tab :exams, :group_nav
  set_tab :admin, :group_nav, only: [:admin]
  
  def index
  end

  def new
    @exam = Exam.new
  end

  def show
    @exam = Exam.find params[:id]
    @students = @current_group.students
  end

  def create
    @exam = Exam.new params[:exam]
    @exam.creator = current_user
    @exam.group = @current_
    @exam.term = @current_group.current_term
    if @exam.save
      redirect_to [:group, @current_groups, @exam]
    else
      render action: :new
    end
  end
end
