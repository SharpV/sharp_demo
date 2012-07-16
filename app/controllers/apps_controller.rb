class AppsController < ApplicationController
  
  
  def index

  end


  def show
    @book_review = BookReview.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @book_review }
    end
  end


  def new
    @book_review = BookReview.new
  end


  def edit
    @book_review = BookReview.find(params[:id])
  end


  def create
    @book_review = BookReview.new(params[:book_review])
    respond_to do |format|
      if @book_review.save
        flash[:notice] = 'BookReview was successfully created.'
        format.html { redirect_to(@book_review) }
        format.xml  { render :xml => @book_review, :status => :created, :location => @book_review }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @book_review.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @book_review = BookReview.find(params[:id])
    respond_to do |format|
      if @book_review.update_attributes(params[:book_review])
        flash[:notice] = 'BookReview was successfully updated.'
        format.html { redirect_to(@book_review) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @book_review.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @book_review = BookReview.find(params[:id])
    @book_review.destroy
    respond_to do |format|
      format.html { redirect_to(book_reviews_url) }
      format.xml  { head :ok }
    end
  end
end
