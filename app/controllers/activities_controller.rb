class ActivitiesController < ApplicationController
  respond_to :html, :js
  
  def create
    @activity = Activity.new params[:activity]
    @activity.actor_id = current_user.id
    @activity.actor_type = current_user.class
    @activity.save
    respond_with do |format|
      format.js
    end
  end
  
  
  # Show a single activity
  def show
    @activity = Activity.find(params[:id])
  end
  
end
