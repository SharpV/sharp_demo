class Webclass::MediaController < WebclassController
  set_tab :courses, :webclass_nav

  def new
    @course = Course.find params[:course_id]
    @medium = Medium.new
    @courses = @current_webclass.courses
  end

  def index
    @courses = @current_webclass.courses
    @course = Course.find params[:course_id]
    @media = @course.media.page params[:page]
    @medium = Medium.new
  end


  def create
    @course = Course.find params[:course_id]
    @medium = Medium.new params[:medium]
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
