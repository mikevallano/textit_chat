class ChatsController < ApplicationController
  before_action :set_chat, only: [:show, :edit, :update, :destroy]

  # GET /chats
  # GET /chats.json
  def index
    @chats = current_user.chats
    chat_id = params[:chat_id]

    if chat_id
      @chat = @chats.find(chat_id)
      @message = Message.new
      @messages = @chat.messages
      user.update_last_read(@chat)
    end
    
  end

end
