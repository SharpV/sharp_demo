class TagsController < ApplicationController
  
  def index
    @tags = Domain.tag_counts_on(:tags).page(params[:page])
  end
  
  def subscribe
  end

end