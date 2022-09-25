class ProductModelsController < ApplicationController
  def index 
    @product_models = ProductModel.all
    if @product_models.empty?
      flash.now.notice = t 'no_product_models_registered'
    end
  end
end