 #encoding: utf-8

class Webclass::AssignmentsController < WebclassController
  respond_to :html, :js
  set_tab :assignments, :webclass_nav
  set_tab :admin, :webclass_nav, only: [:admin]
  def index
    @assignments = @current_webclass.assignments.page params[:page]
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

  end

  def destroy
  end
end
