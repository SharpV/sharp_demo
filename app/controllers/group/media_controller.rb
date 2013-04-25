class Group::MediaController < GroupController
  set_tab :courses, :webclass_nav

  def index
    @courses = @current_group.courses
    @course = Course.find params[:course_id]
    @media = @course.media.page params[:page]
    @medium = Medium.new
    self.try :set_tab, "course_#{@course.id}", :webclass_courses_nav
  end


  def create
    @course = Course.find params[:course_id]
    @medium = Medium.new
    @medium.file = params[:files].first
    respond_to do |format|
      @medium.creator = current_user
      @medium.mediumable = @course
      if @medium.save
        format.json { render json: [@medium.to_jq_upload].to_json, status: :created, location: [@medium] }
      else
        render json: @medium.errors.to_json
      end
    end
  end

  def destroy
    @medium = Medium.find(params[:id])
    @medium.destroy
  end

end
