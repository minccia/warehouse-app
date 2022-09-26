class ProductModelsController < ApplicationController
  def index 
    @product_models = ProductModel.all
  end

  def new 
    @product_model = ProductModel.new
  end

  def create 
    @product_model = ProductModel.new new_product_model_params
    if @product_model.save
      flash.notice = "#{ t 'model' } #{ t 'created_with_success' }"
      return redirect_to product_model_url(@product_model.id)
    end
    flash.now.notice = "#{ t 'model' } #{ t 'not_registered' }"
    render :new, status: :unprocessable_entity
  end

  def show 
    @product_model = ProductModel.find params[:id]
  end

  private

    def new_product_model_params
      params.require(:product_model).permit(
        :name, :sku, :weight, :width,
        :height, :depth, :supplier_id
      )
    end

end