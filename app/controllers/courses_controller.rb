
 # encoding: utf-8

class CoursesController < ApplicationController

  def index
    @courses = Course.page params[:page]
  end

  def show
    @course = Course.find params[:id]
  end

  def new
    @course = Course.new
  end


  def edit
    @html_content = HtmlContent.find(params[:id])
  end


  def create
    @course = Course.new(params[:course])
    @course.user = current_user
    respond_to do |format|
      if @course.save
        flash[:notice] = 'HtmlContent was successfully created.'
        format.html { 
          redirect_to(@course)   
        }
        format.xml  { render :xml => @course, :status => :created, :location => @course }
        format.json  { render :json => @course, :status => :created, :location => @course }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @course.errors, :status => :unprocessable_entity }
        format.json  { render :json => @course.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @html_content = HtmlContent.find(params[:id])
    respond_to do |format|
      if @html_content.update_attributes(params[:html_content])
        flash[:notice] = 'HtmlContent was successfully updated.'
        format.html { 
          if params['admin_page']
            redirect_to('/admin/contents')
          else
            redirect_to('/') 
          end  
         }
        format.xml  { head :ok }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @html_content.errors, :status => :unprocessable_entity }
        format.json  { render :json => @html_content.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @html_content = HtmlContent.find(params[:id])
    @html_content.destroy
    respond_to do |format|
      format.html { redirect_to(html_contents_url) }
      format.xml  { head :ok }
      format.json { head :ok }
    end
  end
end
