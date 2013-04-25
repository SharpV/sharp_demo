 #encoding: utf-8

class Group::AssignmentsController < GroupController
  respond_to :html, :js
  set_tab :assignments, :group_nav
  set_tab :admin, :group_nav, only: [:admin]
  def index
    if params[:course_id]     
      @course = Course.find params[:course_id]
      @assignments = @course.assignments.includes(:creator, :course).page params[:page]
      self.try :set_tab, "course_#{@course.id}", :group_courses_nav
    else
      @assignments = @current_group.assignments.includes(:creator, :course).page params[:page]
    end
    @courses = @current_group.courses
  end

  def edit
    @assignment = Assignment.find params[:id]
    @courses = @current_group.courses
  end

  def new
    @assignment = Assignment.new
    @courses = @current_group.courses
  end

  def create
    @assignment = @current_group.assignments.build params[:assignment]
    @assignment.term = @current_group.current_term
    @assignment.creator = current_user
    if @assignment.save
      redirect_to [:group, @current_group, :assignments]
    else
      render action: :new
    end
  end

  def update
    @assignment = Assignment.find params[:id]
    if @assignment.update_attributes params[:assignment]
      redirect_to [:group, @current_group, :assignments]
    else
      render action: :new
    end
  end

  def destroy
     @assignment = Assignment.find params[:id]
     @assignment.destroy
  end
end
