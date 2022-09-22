class HomeController < ApplicationController
  def index 
    @warehouses = Warehouse.all 
    flash.now.alert = t 'no_warehouses_yet' if @warehouses.empty?
  end

end