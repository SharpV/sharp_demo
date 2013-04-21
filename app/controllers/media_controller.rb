class MediaController < ApplicationController

  def destroy
    @medium = Medium.find(params[:id])
    @medium.destroy
    render :json => true
  end

end
