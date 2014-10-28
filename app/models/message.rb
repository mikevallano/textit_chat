require 'rest_client'

class Message < ActiveRecord::Base
  @@system_sms_phone_name = "DKT"
  @@system_sms_phone_number = "+34664762530"

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
        'Authorization' => "Token 3c1a5032e340eca98b900e2e6a268e525816b4dc"
      }
    )
  end
end
