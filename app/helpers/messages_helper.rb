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

  def message_placeholder(faq, follow)
    resp = assemble_response(faq, follow)
    resp.blank? ? "Enter text to send message" : resp
  end

  def message_value(faq, follow)
    resp = assemble_response(faq, follow)
    resp.blank? ? nil : resp
  end

  def assemble_response(faq, follow)
    resp = []
    resp << faq.answer if faq.present?
    resp << follow.question if follow.present?
    resp.join(" ")
  end

  def url_for_template(chat, faq, follow)
    return url_for(chat_id: chat.id, faq_id: faq.id, follow_id: follow.id) if faq && follow
    return url_for(chat_id: chat.id, faq_id: faq.id) if faq
    return url_for(chat_id: chat.id, follow_id: follow.id)
  end
end
