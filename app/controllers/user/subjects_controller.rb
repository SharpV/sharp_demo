class My::SubjectsController < ApplicationController

  def new
    @reply = Reply.new
  end


  def edit
    @reply = Reply.find(params[:id])
  end


  def create
    @reply = Reply.new(params[:reply])
    respond_to do |format|
      if @reply.save
        flash[:notice] = 'Reply was successfully created.'
        format.html { redirect_to(@reply) }
        format.xml  { render :xml => @reply, :status => :created, :location => @reply }
        format.json  { render :json => @reply, :status => :created, :location => @reply }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @reply.errors, :status => :unprocessable_entity }
        format.json  { render :json => @reply.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @reply = Reply.find(params[:id])
    respond_to do |format|
      if @reply.update_attributes(params[:reply])
        flash[:notice] = 'Reply was successfully updated.'
        format.html { redirect_to(@reply) }
        format.xml  { head :ok }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @reply.errors, :status => :unprocessable_entity }
        format.json  { render :json => @reply.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @reply = Reply.find(params[:id])
    @reply.destroy
    respond_to do |format|
      format.html { redirect_to(replies_url) }
      format.xml  { head :ok }
      format.json { head :ok }
    end
  end
  
end
