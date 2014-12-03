#  Parameters: {"run"=>"188699", "phone"=>"+447756205670", "text"=>"Need abortipn", "flow"=>"19251", "relayer"=>"2714", "step"=>"71f79e62-8165-45d8-8221-a32af4f9585a", "values"=>"[{\"category\": \"Other\", \"time\": \"2014-12-03T12:48:57.217696Z\", \"text\": \"Need abortipn\", \"rule_value\": \"Need abortipn\", \"value\": \"Need abortipn\", \"label\": \"Quit\"}]", "time"=>"2014-12-03T12:50:11.181679Z", "steps"=>"[{\"node\": \"6aa3f94b-0388-4b46-ad49-c1fe98815c83\", \"arrived_on\": \"2014-12-03T12:48:57.189449Z\", \"left_on\": \"2014-12-03T12:48:57.211695Z\", \"text\": \"Thanks for contacting safe2choose! You are about to start a live chatting session with an expert counsellor. It may take a few moments before you hear back from us. Meanwhile, let us know how we can help you today? Send 'quit' to quit.\", \"type\": \"A\", \"value\": null}, {\"node\": \"7f6b27b9-e383-45c4-92fa-19c9352348e1\", \"arrived_on\": \"2014-12-03T12:48:57.217696Z\", \"left_on\": null, \"text\": \"Need abortipn\", \"type\": \"R\", \"value\": \"Need abortipn\"}]", "channel"=>"2714"}
# 2014-12-03T12:50:11.310278+00:00 app[web.1]: Started GET "/users/sign_in" for 54.211.208.127 at 2014-12-03 12:50:11 +000
require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "create from textit" do
    phone = "12345"
    text = "Fake text"
    params = { phone: phone, text: text}
    message = Message.create_from_textit params
    client = Client.find_by(phone_number: phone)

    assert message.to == Message.system_sms_phone_number
    assert message.from == phone
    assert message.message == text
    assert message.sent_by_system == false
    assert message.chat == client.chats.first

    assert client.chats.size == 1

  end
end
