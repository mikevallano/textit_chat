require 'rest_client'

class Message < ActiveRecord::Base
  belongs_to :chat
  @@system_sms_phone_name = "DKT"
  @@system_sms_phone_number = "+441618504838"

  before_save :set_sent_at

  def self.system_sms_phone_number
    @@system_sms_phone_number
  end

  def self.system_sms_phone_name
    @@system_sms_phone_name
  end

  def send_textit_sms
    textit_endpoint = "https://api.textit.in/api/v1/messages.json"
    RestClient.post(
      textit_endpoint,
      {
        "text" => message,
        "phone" => to
      },
      {
        "Content-Type" => 'application/json',
        # 'Authorization' => "Token 3c1a5032e340eca98b900e2e6a268e525816b4dc" # SPAIN
        'Authorization' => "Token 5e468a10abab2274ff013cc42acd3dfd064a4a82" # UK
      }
    )
  end

  def self.create_from_textit(params)
    chat_name = params[:phone]
    if chat_name.present?
      client = Client.find_or_create_by(phone_number: chat_name)
      chat = client.chats.first_or_create!

      message = Message.create(
        to: Message.system_sms_phone_number,
        from: chat_name,
        sent_at: Time.zone.now,
        message: params[:text],
        sent_by_system: false,
        chat: chat
      )

      User.subscribe_all(chat)

      return message
    end

    return nil
  end

  def self.new_from_chat(params, user)
    message = Message.new(params)
    message.sent_by_system = true
    message.from = User.email
    client = Client.find_or_create_by(phone_number: message.to)
    chat = client.chats.first_or_create!
    message.chat = chat

    message
  end

  def self.new_push_notification(to, message)
    client = Client.find_or_create_by(phone_number: to)
    chat = client.chats.first_or_create!

    Message.new(
      sent_at: Time.zone.now,
      to: to,
      from: Message.system_sms_phone_number,
      message: message,
      chat: chat
    )
  end

  def beneficiary_message?
    to == Message.system_sms_phone_number
  end

  def set_sent_at
    self.sent_at ||= Time.zone.now
  end
end
