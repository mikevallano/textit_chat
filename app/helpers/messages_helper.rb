module MessagesHelper
  def sanitize_to_field(to)
    to == Message.system_sms_phone_number ? Message.system_sms_phone_name : to
  end

  def message_format_tag(message)
    if message.beneficiary_message?
      return "col-sm-6 well beneficiary-message-well"
    else
      return "col-sm-6 col-sm-offset-5 well"
    end
  end
end
