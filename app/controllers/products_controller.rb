class ProductsController < ApplicationController
  respond_to :html, :js
  
  def detail
    @product = Product.find params[:id]
  end

end
