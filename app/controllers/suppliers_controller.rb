class SuppliersController < ApplicationController
  def index 
    @suppliers = Supplier.all
  end

  def new 
    @supplier = Supplier.new
  end

  def create 
    @supplier = Supplier.create new_supplier_params
    if @supplier.save 
      flash.notice = "#{ t 'activerecord.models.supplier' } #{ t 'created_with_success' }"
      return redirect_to suppliers_url
    end
    flash.now.notice = "#{ t 'activerecord.models.supplier' } #{ t 'not_registered'  }"
    render :new, status: :unprocessable_entity
  end

  private 
    def new_supplier_params
      params.require(:supplier).permit(
        :corporate_name, :brand_name, :registration_number,
        :full_address, :city, :state, :email, :phone_number
      )
    end
end