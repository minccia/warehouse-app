class WarehousesController < ApplicationController
  def show 
    @wh = Warehouse.find params[:id]
  end

end