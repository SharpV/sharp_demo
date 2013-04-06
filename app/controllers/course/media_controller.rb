class Course::MediaController < CourseController

  respond_to :html, :json

  set_tab :media, :me_nav
  set_tab :media, :media_nav
  
  def index
    @slot = Slot.find params[:slot_id]
    @media = @slot.media
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @media.map{|upload| upload.to_jq_upload } }
    end
  end


  def create
    @slot = Slot.find params[:slot_id]
    @medium = @slot.media.build params[:medium]
    respond_to do |format|
      @medium.creator = current_user
      if @medium.save
        format.json { render json: [@medium.to_jq_upload].to_json, status: :created, location: [:me, @medium] }
      else
        render json: @medium.errors.to_json
      end
    end
  end

  def destroy
    @medium = Medium.find(params[:id])
    @medium.destroy
    render :json => true
  end
end
