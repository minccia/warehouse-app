class WarehousesController < ApplicationController
  def show 
    @wh = Warehouse.find params[:id]
  end

  def new 
    @warehouse = Warehouse.new
  end

  def create  
    warehouse = Warehouse.create new_warehouse_params
    if warehouse.save
      flash.notice = 'Galpão criado com sucesso'
      return redirect_to root_path 
    end
    render :new, status: :unprocessable_entity
  end

  private 
    def new_warehouse_params
      params.require(:warehouse).permit(
        :name, :code, :area, :city, 
        :zip_code, :address, :description
      )
    end
end