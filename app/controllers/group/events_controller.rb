class My::EventsController < MyController
  before_filter :find_user
  set_tab :event, :user_menus
  # GET /my/events
  # GET /my/events.json
  def index
 
  end

  # GET /my/events/1
  # GET /my/events/1.json
  def show
    @my_event = My::Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @my_event }
    end
  end

  # GET /my/events/new
  # GET /my/events/new.json
  def new
    @my_event = My::Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @my_event }
    end
  end

  # GET /my/events/1/edit
  def edit
    @my_event = My::Event.find(params[:id])
  end

  # POST /my/events
  # POST /my/events.json
  def create
    @my_event = My::Event.new(params[:my_event])

    respond_to do |format|
      if @my_event.save
        format.html { redirect_to @my_event, :notice => 'Event was successfully created.' }
        format.json { render :json => @my_event, :status => :created, :location => @my_event }
      else
        format.html { render :action => "new" }
        format.json { render :json => @my_event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /my/events/1
  # PUT /my/events/1.json
  def update
    @my_event = My::Event.find(params[:id])

    respond_to do |format|
      if @my_event.update_attributes(params[:my_event])
        format.html { redirect_to @my_event, :notice => 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @my_event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /my/events/1
  # DELETE /my/events/1.json
  def destroy
    @my_event = My::Event.find(params[:id])
    @my_event.destroy

    respond_to do |format|
      format.html { redirect_to my_events_url }
      format.json { head :no_content }
    end
  end
end
