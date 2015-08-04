require 'rest-client'

class Message < ActiveRecord::Base
  belongs_to :chat
  @@system_sms_phone_name = "safe2choose"
  @@system_sms_phone_number = "+441618504838"

  before_save :set_sent_at

  has_paper_trail

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
        'Authorization' => "Token #{textit_token}"
      }
    ) unless Rails.env == "test"
  end

  def self.create_from_textit(params)
    chat_name = params[:phone]
    if chat_name.present?
      client = Client.find_or_create_by(phone_number: chat_name)
      chat = client.chat

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

  def textit_token
    to.match(/\+1/).present? ? ENV['TEXT_IT_TOKEN_US'] : ENV['TEXT_IT_TOKEN_UK']
  end

  def self.new_from_chat(params, user)
    message = Message.new(params)
    message.sent_by_system = true
    message.from = user.email
    client = Client.find_or_create_by(phone_number: message.to)
    chat = client.chat
    message.chat = chat


    message
  end

  def self.new_push_notification(to, message)
    client = Client.find_or_create_by(phone_number: to)
    chat = client.chat

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
