 #encoding: utf-8

class Webclass::AssignmentsController < WebclassController
  respond_to :html, :js
  set_tab :assignments, :webclass_nav
  set_tab :admin, :webclass_nav, only: [:admin]
  def index
    if params[:course_id]     
      @course = Course.find params[:course_id]
      @assignments = @course.assignments.includes(:creator, :course).page params[:page]
      self.try :set_tab, "course_#{@course.id}", :webclass_courses_nav
    else
      @assignments = @current_webclass.assignments.includes(:creator, :course).page params[:page]
    end
    @courses = @current_webclass.courses
  end

  def edit
    @assignment = Assignment.find params[:id]
    @courses = @current_webclass.courses
  end

  def new
    @assignment = Assignment.new
    @courses = @current_webclass.courses
  end

  def create
    @assignment = @current_webclass.assignments.build params[:assignment]
    @assignment.term = @current_webclass.current_term
    @assignment.creator = current_user
    if @assignment.save
      redirect_to [:webclass, @current_webclass, :assignments]
    else
      render action: :new
    end
  end

  def update
    @assignment = Assignment.find params[:id]
    if @assignment.update_attributes params[:assignment]
      redirect_to [:webclass, @current_webclass, :assignments]
    else
      render action: :new
    end
  end

  def destroy
     @assignment = Assignment.find params[:id]
     @assignment.destroy
  end
end
