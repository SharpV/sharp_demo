class AssetsController < InheritedResources::Base

	def index
    	@assets = Asset.all
    	render :json => @assets.collect { |p| p.to_jq_upload }.to_json
  	end
	
	# POST /uploads
  	# POST /uploads.json
  	def create
    	@asset = Asset.new(params[:asset])
    	@asset.assetable_id = params[:id]
    	@asset.assetable_type = params[:type]
    	respond_to do |format|
      		if @asset.save
        		format.html {
          			render :json => [@asset.to_jq_upload].to_json, :content_type => 'text/html', :layout => false
        		}
        		format.json { 
        			puts [@asset.to_jq_upload].to_json.inspect
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
