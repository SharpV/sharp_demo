class My::GroupsController < MyController
  before_filter :find_user
  set_tab :group, :user_menus
  
  # GET /my/groups
  # GET /my/groups.json
  def index
    @groups = Group.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @groups }
    end
  end

  # GET /my/groups/1
  # GET /my/groups/1.json
  def show
    @my_group = My::Group.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @my_group }
    end
  end

  # GET /my/groups/new
  # GET /my/groups/new.json
  def new
    @my_group = My::Group.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @my_group }
    end
  end

  # GET /my/groups/1/edit
  def edit
    @my_group = My::Group.find(params[:id])
  end

  # POST /my/groups
  # POST /my/groups.json
  def create
    @my_group = My::Group.new(params[:my_group])

    respond_to do |format|
      if @my_group.save
        format.html { redirect_to @my_group, :notice => 'Group was successfully created.' }
        format.json { render :json => @my_group, :status => :created, :location => @my_group }
      else
        format.html { render :action => "new" }
        format.json { render :json => @my_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /my/groups/1
  # PUT /my/groups/1.json
  def update
    @my_group = My::Group.find(params[:id])

    respond_to do |format|
      if @my_group.update_attributes(params[:my_group])
        format.html { redirect_to @my_group, :notice => 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @my_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /my/groups/1
  # DELETE /my/groups/1.json
  def destroy
    @my_group = My::Group.find(params[:id])
    @my_group.destroy

    respond_to do |format|
      format.html { redirect_to my_groups_url }
      format.json { head :no_content }
    end
  end
end
