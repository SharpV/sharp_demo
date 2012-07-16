class EventsController < ApplicationController

  before_filter :login_required, :only => [:new, :edit, :create, :update]
 
  def index
    @events = Event.find(:all, :order => 'created_at DESC')
  end


  def show
    @event = Classified.find(params[:id])
  end


  def new
    @event = Event.new
  end


  def edit
    @event = Event.find(params[:id])
  end


  def create
    @event = Event.new(params[:classified])
    @event.user = current_user;
    respond_to do |format|
      if @event.save
        flash[:notice] = 'Classified was successfully created.'
        format.html { redirect_to @event }
      else
        format.html { render :action => "new" }
      end
    end
  end


  def update
    @event = Event.find(params[:id])
    respond_to do |format|
      if @event.update_attributes(params[:event])
        flash[:notice] = 'Classified was successfully updated.'
        format.html { redirect_to(@event) }
      else
        format.html { render :action => "edit" }
      end
    end
  end


  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    respond_to do |format|
      format.html { redirect_to(events_path) }
      format.xml  { head :ok }
      format.json { head :ok }
    end
  end
end
