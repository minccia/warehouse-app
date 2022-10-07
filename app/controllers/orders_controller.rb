class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new 
    @order = Order.new
  end

  def create 
    @order = Order.new new_order_params
    @order.user = current_user
    if @order.save
      flash.notice = "#{ t 'activerecord.models.order'} #{ t 'created_with_success'}"
      return redirect_to @order
    end
    flash.now.notice = "#{ t 'activerecord.models.order'} #{ t 'not_registered' }"
    render :new, status: :unprocessable_entity
  end

  def show 
    @order = Order.find params[:id]
  end

  private
    
    def ensure_user_is_the_same_as_creator
      unless @order.user == current_user
        flash.notice = "#{ t 'no_permission_to_edit' }"
        return redirect_to orders_path
      end
    end

    def new_order_params
      params.require(:order).permit(
        :warehouse_id, :supplier_id, :user_id,
        :estimated_delivery_date
        )
    end
end