class My::LikesController < MyController
  before_filter :find_user
  set_tab :like, :user_menus
  before_filter :authenticate_user!
  
  def index
  end
  
  def create
    target = Likeable.find_by_resource_id(params[:resource_name], params[:resource_id])
    current_user.like!(target)
    redirect_to :back, :notice => 'success'
  end

  def destroy
    target = Likeable.find_by_resource_id(params[:resource_name], params[:resource_id])
    current_user.unlike!(target)
    redirect_to :back, :notice => 'success'
  end
end
