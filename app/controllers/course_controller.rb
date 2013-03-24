class CourseController < ApplicationController
  before_filter :authenticate_user!, :set_current_course_context  
  layout "course"

  set_tab "course", :site_nav
  
  def set_current_course_context
    @course = Course.find(params[:course_id])
    @course_member = @course.member(current_user)
  rescue    
    @course = nil
    @course_member = nil
  end
 
end
