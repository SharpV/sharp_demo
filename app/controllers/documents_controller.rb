class DocumentsController < ApplicationController
  def index
  end
  
  def create
    if @doc = current_user.documents.build params[:document]
      redirect_to @doc
    else
      render :action = :new
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
