class ChatsController < ApplicationController
  layout "two_column"

  # GET /chats
  # GET /chats.json
  def index
    @chats = current_user.chats
    chat_id = params[:chat_id]

    if chat_id
      @chat = @chats.find(chat_id)
      @message = Message.new
      @messages = @chat.messages
      @messages = @messages.sort { |x,y| y.sent_at <=> x.sent_at }
      current_user.update_last_read(@chat)

      @faqs = Faq.all
      faq_id = params[:faq_id]

      if faq_id
        @faq = @faqs.find(faq_id)
      end
    end

    @chats = @chats.sort  { |x,y| y.most_recent_message_time <=> x.most_recent_message_time }
  end

end
