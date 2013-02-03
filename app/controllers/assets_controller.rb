class AssetsController < InheritedResources::Base
	def create
    	@asset = Asset.new
    	@asset.file = params[:asset][:path].shift
    	if @asset.save
      		respond_to do |format|
        		format.html {                                         #(html response is for browsers using iframe sollution)
          			render :json => [@asset.to_jq_upload].to_json, :content_type => 'text/html', :layout => false
        		}	
        		format.json {
          			render :json => [@asset.to_jq_upload].to_json
        		}
      		end
    	else
      		render :json => [{:error => "custom_failure"}], :status => 304
    	end
  	end

  	def destroy
    	@asset = Asset.find(params[:id])
    	@asset.destroy
    	render :json => true
  	end
end
