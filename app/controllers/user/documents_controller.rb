class Group::DocumentsController < GroupController
  set_tab :document, :group_menus
  
  def index
  end

  def create
    @doc = current_user.documents.build(params[:document])
    if @doc.save
      redirect_to [@current_group, @doc]
    else
      render :action => :new
    end
  end

  def show
    @doc = Document.find params[:id]
  end

  def new
    @document = Document.new
  end

  def edit
  end

  def destory
  end

end
