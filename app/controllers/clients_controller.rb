class ClientsController < ApplicationController
  before_action :set_client, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @clients = Client.all
    client_id = params[:client_id]

    if client_id
      @client = @clients.find(client_id)
    end

  end

  def show
    redirect_to clients_path(client_id: @client.id)
  end

  def new
    @client = Client.new
  end

  def edit
  end

  def create
    @client = Client.new(client_params)
    @client.save
  end

  def update
    @client.update(client_params)
  end

  def destroy
    @client.destroy
  end

  private
    def set_client
      @client = Client.find(params[:id])
    end

    def client_params
      params.require(:client).permit(:phone_number, :name, :address)
    end
end
