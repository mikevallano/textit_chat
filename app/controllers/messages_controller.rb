class MessagesController < ApplicationController
  skip_before_filter :authenticate_user!, :only => :create_from_textit
  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new_from_chat(message_params, current_user)

    respond_to do |format|
      if @message.save
        # binding.pry

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
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:message, :to)
    end

end