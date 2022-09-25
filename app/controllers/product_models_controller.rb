class ProductModelsController < ApplicationController
  def index 
    @product_models = ProductModel.all
    if @product_models.empty?
      flash.now.notice = 'Não há modelos de produtos cadastrados'
    end
  end
end