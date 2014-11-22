class OrdersController < ApplicationController
  def index
    @orders = current_user.orders
    order_id = params[:order_id]

    if order_id
      @order = @orders.find(order_id)
      @order_update = OrderUpdate.new
    end

    @orders = @orders.sort  { |x,y| y.created_at <=> x.created_at }
  end
end
