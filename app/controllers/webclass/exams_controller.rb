class Webclass::ExamsController < WebclassController
  respond_to :html, :js
  set_tab :exams, :webclass_nav
  set_tab :admin, :webclass_nav, only: [:admin]
  
  def index
  end

  def new
    @exam = Exam.new
  end

  def show
    @exam = Exam.find params[:id]
    @students = @current_webclass.group_members(:student)
  end

  def create
    @exam = Exam.new params[:exam]
    @exam.creator = current_user
    @exam.webclass = @current_webclass
    @exam.term = @current_webclass.current_term
    if @exam.save
      redirect_to [:webclass, @current_webclass, @exam]
    else
      render action: :new
    end
  end
end
