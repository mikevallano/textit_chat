class OrdersController < ApplicationController
  layout "two_column"
  skip_before_filter :authenticate_user!, :only => :create_from_textit

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

  # POST /orders/create_from_textit
  def create_from_textit
    @order = Order.create_from_textit params
    @order.assign_to_all_users
  end
end