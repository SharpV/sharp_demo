class MediaController < ApplicationController
  respond_to :html, :js
  def destroy
    @medium = Medium.find(params[:id])
    @medium.destroy
  end
end
