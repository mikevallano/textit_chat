class OrdersController < ApplicationController
  layout "two_column"

  def index
    @orders = Order.all
    order_id = params[:order_id]

    if order_id
      @order = @orders.find(order_id)
      @order_update = OrderUpdate.new
    end

    respond_to do |format|
      format.html
      format.csv { render text: @orders.to_csv }
      format.xls
    end

    @orders = @orders.sort  { |x,y| y.created_at <=> x.created_at }


  end

end