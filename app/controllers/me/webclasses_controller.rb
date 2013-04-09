class Me::WebclassesController < MeController
  set_tab :webclasses, :me_nav
  set_tab :index, :webclass_nav
  
  def index
    @webclasses = current_user.webclasses.page params[:page]
  end 

  def new
    @webclass = Webclass.new
  end

  def create 
    @webclass = Webclass.new params[:webclass]
    @webclass.creator = current_user
    if @webclass.save
      redirect_to admin_webclass_webclass_settings_path(@webclass)
    else
      render action: :new
    end
  end

  def manage
    @courses = Course.where(creator_id: current_user.id)
  end
end
