class MessagesController < ApplicationController
  skip_before_filter :authenticate_user!, :only => :create_from_textit
  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.sent_by_system = true
    @message.from = Message.system_sms_phone_number
    last_message = Message.where(sent_by_system: false).order("created_at desc").first
    @message.to = params[:destination]
    client = Client.find_or_create_by(phone_number: @message.to)
    chat = client.chats.first_or_create!
    @message.chat = chat

    respond_to do |format|
      if @message.save
        @message.send_textit_sms
        format.html { redirect_to chats_path(chat_id: @message.chat.id), notice: 'Message was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # POST /messages/create_from_textit
  # POST /messages/create_from_textit.json
  def create_from_textit
    @message = Message.create_from_textit params
    User.subscribe_all(chat) if @message.present?
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:message)
    end

end