class SuppliersController < ApplicationController
  before_action :fetch_supplier, only: %i[show edit update]
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

  def show; end

  def edit; end

  def update 
    if @supplier.update new_supplier_params
      flash.notice = "#{ t 'activerecord.models.supplier' } #{ t 'updated_with_success' }"
      return redirect_to supplier_url(@supplier.id)
    end
    flash.now.notice = "#{ t 'activerecord.models.supplier' } #{ t 'not_updated' }"
    render :edit, status: :unprocessable_entity
  end

  private 

    def fetch_supplier
      @supplier = Supplier.find params[:id]
    end

    def new_supplier_params
      params.require(:supplier).permit(
        :corporate_name, :brand_name, :registration_number,
        :full_address, :city, :state, :email, :phone_number
      )
    end
end