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
#  Parameters: {"run"=>"188699", "phone"=>"+447756205670", "text"=>"Need abortipn", "flow"=>"19251", "relayer"=>"2714", "step"=>"71f79e62-8165-45d8-8221-a32af4f9585a", "values"=>"[{\"category\": \"Other\", \"time\": \"2014-12-03T12:48:57.217696Z\", \"text\": \"Need abortipn\", \"rule_value\": \"Need abortipn\", \"value\": \"Need abortipn\", \"label\": \"Quit\"}]", "time"=>"2014-12-03T12:50:11.181679Z", "steps"=>"[{\"node\": \"6aa3f94b-0388-4b46-ad49-c1fe98815c83\", \"arrived_on\": \"2014-12-03T12:48:57.189449Z\", \"left_on\": \"2014-12-03T12:48:57.211695Z\", \"text\": \"Thanks for contacting safe2choose! You are about to start a live chatting session with an expert counsellor. It may take a few moments before you hear back from us. Meanwhile, let us know how we can help you today? Send 'quit' to quit.\", \"type\": \"A\", \"value\": null}, {\"node\": \"7f6b27b9-e383-45c4-92fa-19c9352348e1\", \"arrived_on\": \"2014-12-03T12:48:57.217696Z\", \"left_on\": null, \"text\": \"Need abortipn\", \"type\": \"R\", \"value\": \"Need abortipn\"}]", "channel"=>"2714"}
# 2014-12-03T12:50:11.310278+00:00 app[web.1]: Started GET "/users/sign_in" for 54.211.208.127 at 2014-12-03 12:50:11 +000
  # POST /messages/create_from_textit
  # POST /messages/create_from_textit.json
  def create_from_textit
    chat_name = params[:phone]
    if chat_name.present?
      client = Client.find_or_create_by(phone_number: chat_name)
      chat = client.chats.first_or_create!

      @message = Message.new(
        to: Message.system_sms_phone_number,
        from: chat_name,
        sent_at: Time.zone.now,
        message: params[:text],
        relayer: params[:relayer],
        sent_by_system: false,
        chat: chat
      )

      User.subscribe_all chat

    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:message)
    end

end