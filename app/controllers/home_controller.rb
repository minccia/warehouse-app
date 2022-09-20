class HomeController < ApplicationController
  def index 
    @warehouses = Warehouse.all 
    flash.now[:notice] = t('no_warehouses_yet') if @warehouses.empty?
  end

end