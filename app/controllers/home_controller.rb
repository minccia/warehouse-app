class HomeController < ApplicationController
  def index 
    @warehouses = Warehouse.all 
    flash.notice = 'Não há galpões cadastrados ainda' if @warehouses.empty?
  end
  
end