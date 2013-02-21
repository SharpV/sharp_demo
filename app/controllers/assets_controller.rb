class AssetsController < ApplicationController

	 def index
      puts "\n ********* " + session[:assets].inspect
    	@assets = session[:assets] || []
    	respond_to do |format|
        #puts "\n \n ******* #{@assets.map{|asset| asset.to_jq_upload}}"
        format.html # index.html.erb
        format.json { render json: @assets.map{|asset| asset.to_jq_upload } }
    end
   end

  def create
    @asset = Asset.new(params[:asset])
    @asset.assetable_id = params[:id]
    @asset.assetable_type = params[:type]
    respond_to do |format|
      if @asset.save
        #unless session[:assets] && session[:assets].kind_of?(Array)
          #session[:assets] = Array.new
        #end
        session[:expires_at] = Time.now + 10.hour
        session[:assets] = @asset.id
        puts "\n *********" + session[:assets].inspect

        format.html {
          render :json => [@asset.to_jq_upload].to_json, :content_type => 'text/html', :layout => false
        }
        format.json { 
        	render json: [@asset.to_jq_upload].to_json, status: :created, location: @asset 
      	}
    	else
     			render :json => [{:error => "custom_failure"}], :status => 304
    	end
  	end
  end

  def destroy
    	@asset = Asset.find(params[:id])
    	@asset.destroy
    	render :json => true
  end
end
