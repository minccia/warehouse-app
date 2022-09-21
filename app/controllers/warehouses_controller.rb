class WarehousesController < ApplicationController
  def show 
    @warehouse = Warehouse.find params[:id]
  end

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

  def edit 
    @warehouse = Warehouse.find params[:id]
  end

  def update 
    @warehouse = Warehouse.find params[:id]
    if @warehouse.update new_warehouse_params
      flash.notice = "#{ t 'activerecord.models.warehouse' } #{ t 'updated_with_success' }"
      return redirect_to warehouse_path(@warehouse.id)
    end
    flash.now.notice = "#{ t 'activerecord.models.warehouse' } #{ t 'not_updated' }"
    render :edit, status: :unprocessable_entity
  end

  private 
    def new_warehouse_params
      params.require(:warehouse).permit(
        :name, :code, :area, :city, 
        :zip_code, :address, :description
      )
    end
end