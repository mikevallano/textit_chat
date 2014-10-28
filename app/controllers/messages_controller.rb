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
    @message.sent_by_system = true
    @message.from = Message.system_sms_phone_number
    # @message.to = "+34664762530"
    last_message = Message.where(sent_by_system: false).order("created_at desc").first
    @message.to = last_message.from

    respond_to do |format|
      if @message.save
        @message.send_textit_sms
        format.html { redirect_to messages_path, notice: 'Message was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end


  # POST /messages
  # POST /messages.json
  def create_test

  end

  # POST /messages/create_from_textit
  # POST /messages/create_from_textit.json
  def create_from_textit
    # pry
    @message = Message.new(
      to: Message.system_sms_phone_number,
      from: params[:phone],
      message: params[:text],
      relayer: params[:relayer],
      sent_by_system: false
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

  # POST /messages/start_from_textit
  # POST /messages/start_from_textit.json
  def start_from_textit
    Message.waiting = true
  end

  def clear_wait
    Message.waiting = false
    redirect_to messages_path
    Thread.new do
        uri = URI.parse("https://api.textit.in/api/v1/messages.json")
        https = Net::HTTP.new(uri.host,uri.port)
        https.use_ssl = true
        req = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' =>'application/json'})
        req['Authorization'] = "Token 3c1a5032e340eca98b900e2e6a268e525816b4dc"

        req.body = "[ #{@toSend} ]"

        res = https.request(req)

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
