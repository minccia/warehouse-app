class HomeController < ApplicationController
  def index 
    @warehouses = Warehouse.all 
    flash.now[:notice] = 'Não há galpões cadastrados ainda' if @warehouses.empty?
  end

end