require 'rest_client'

class Message < ActiveRecord::Base
  belongs_to :chat
  @@system_sms_phone_name = "DKT"
  @@system_sms_phone_number = "+441234480329"

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

  def beneficiary_message?
    to == Message.system_sms_phone_number
  end

  def set_sent_at
    self.sent_at ||= Time.zone.now
  end
end
