class MediaController < ApplicationController

  def new

  end

  def create
    @medium = Asset.new(file: params[:file])

    if @medium.save
      render json: @medium
    else
      head :bad_request
    end
  end

end
