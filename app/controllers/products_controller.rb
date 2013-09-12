class ProductsController < ApplicationController
  respond_to :html, :js
  
  def detail
    @product = Product.find params[:id]
  end


  def zip_code
    @product = Product.new
  end

  def get_images
    if ZipImage.where(image_url: "exit_flag", zipcode: params[:zip]).blank?
      system "rake demo:new:load zipcode=#{params[:zip]}"
      loop_count = 0
      loop do
        loop_count += 1
        zipimages = ZipImage.where("image_url is not null")
        break_flag = false
        zipimages.each do |zipimage|
          if zipimage.image_url == 'exit_flag' and zipimage.zipcode == params[:zip]
            break_flag = true
            break
          else
            zipimage.image = open zipimage.image_url rescue ""
            zipimage.image_url = nil
            zipimage.save
          end
        end
        break if break_flag or loop_count > 2000
      end
    end
    @zip_images = ZipImage.find_all_by_zipcode(params[:zip])
  end
end
