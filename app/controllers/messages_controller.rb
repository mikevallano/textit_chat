require 'uri'
require 'net/http'
require 'net/https'

class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.all
    @message = Message.new
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }

          Thread.new do
            last_message = @message.where(to: "DKT - OAP").first
            @toSend = {
                "text" => @message.message,
                "phone" => last_message.from,
                "relayer" => last_message.relayer

            }.to_json


            uri = URI.parse("https://api.textit.in/api/v1/messages.json")
            https = Net::HTTP.new(uri.host,uri.port)
            https.use_ssl = true
            req = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
            req['Authorization'] = "Token 3c1a5032e340eca98b900e2e6a268e525816b4dc"

            req.body = "[ #{@toSend} ]"

            res = https.request(req)

          end
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /messages/create_from_textit
  # POST /messages/create_from_textit.json
  def create_from_textit
    # pry
    @message = Message.new(
      to: "DKT - OAP",
      from: params[:phone],
      message: params[:text],
      relayer: params[:relayer]
    )

    respond_to do |format|
      if @message.save
        format.html { redirect_to @message, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  #     POST http://www.yourapp.com/app.php?password=akabanga
# event=flow&relayer=254&relayer_phone=%2B250788111111&phone=%2B250788123123&flow=1524&step=12341234-1234-1234-1234-1234-12341234&values=[]


  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:message)
    end

end
