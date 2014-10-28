module MessagesHelper
  def sanitize_to_field(to)
    to == Message.system_sms_phone_number ? Message.system_sms_phone_name : to
  end
end
