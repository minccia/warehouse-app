class HomeController < ApplicationController
  def index 
    @warehouses = Warehouse.all 
    flash.notice = 'Não há galpões cadastrados ainda' if @warehouses.empty?
  end

  def show 
    @warehouse = Warehouse.find(params[:id])
  end
  
end