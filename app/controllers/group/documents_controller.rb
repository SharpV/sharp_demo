class Group::DocumentsController < GroupController
  def index
  end

  def create
    @doc = current_user.documents.build(params[:document])
    if @doc.save
      redirect_to @doc
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
