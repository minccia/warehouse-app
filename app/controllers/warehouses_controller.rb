class WarehousesController < ApplicationController
  before_action :set_warehouse, only: %i[show edit update destroy]

  def show; end

  def new 
    @warehouse = Warehouse.new
  end

  def create  
    @warehouse = Warehouse.create new_warehouse_params
    if @warehouse.save
      flash.notice = "#{ t 'activerecord.models.warehouse' } #{ t 'created_with_success' }"
      return redirect_to root_url
    end
    flash.now.notice = "#{ t 'activerecord.models.warehouse' } #{ t 'not_registered'  }"
    render :new, status: :unprocessable_entity
  end

  def edit; end

  def update 
    if @warehouse.update new_warehouse_params
      flash.notice = "#{ t 'activerecord.models.warehouse' } #{ t 'updated_with_success' }"
      return redirect_to warehouse_url(@warehouse.id)
    end
    flash.now.notice = "#{ t 'activerecord.models.warehouse' } #{ t 'not_updated' }"
    render :edit, status: :unprocessable_entity
  end

  def destroy 
    @warehouse.destroy
    flash.notice = "#{ t 'activerecord.models.warehouse' } #{ t 'deleted_with_success' }"
    return redirect_to root_url
  end

  private 

    def set_warehouse
      @warehouse = Warehouse.find params[:id]
    end

    def new_warehouse_params
      params.require(:warehouse).permit(
        :name, :code, :area, :city, 
        :zip_code, :address, :description
      )
    end

end