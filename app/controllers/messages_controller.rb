class MessagesController < ApplicationController

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.sent_by_system = true
    @message.from = Message.system_sms_phone_number
    last_message = Message.where(sent_by_system: false).order("created_at desc").first
    @message.to = params[:destination]
    @message.chat = Chat.find_or_create_by name: @message.to

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
    @message = Message.new(
      to: Message.system_sms_phone_number,
      from: params[:phone],
      message: params[:text],
      relayer: params[:relayer],
      sent_by_system: false,
      chat: Chat.find_or_create_by(name: params[:phone])
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

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:message)
    end

end