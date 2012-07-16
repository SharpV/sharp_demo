class LinksController < ApplicationController
  respond_to :html, :js
  def load
    if params[:url].present?
      url = params[:url]
      begin
        link = Linkser.parse url, {:max_images => 1}
        if link.is_a? Linkser::Objects::HTML
          #puts link.inspect
          respond_with do |format|
            format.js {render :content_type => 'text/javascript', :locals => {:link => link}}
          end
          return
        end
      rescue
        respond_with do |format|
          format.js {render :content_type => 'text/javascript', :locals => {:link => nil}}
        end
        return   
      end
    end
  end
end
