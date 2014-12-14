require 'test_helper'

class PushNotificationTest < ActiveSupport::TestCase
  test "sends push notificaitons to client" do
    c1 = Client.create!(phone_number: rand_number, general_information_requested: true)

    PushNotification.push

    assert Chat.where(client_id: c1.id).first.messages.size == 1

    c2 = Client.create!(phone_number: rand_number, general_information_requested: true)
    PushNotification.push

    assert Chat.where(client: c1).first.messages.size == 2
    assert Chat.where(client: c2).first.messages.size == 1
  end

  test "does not send push notifications to unsubscribed client" do
    c1 = Client.create!(phone_number: rand_number)
    PushNotification.push

    assert Chat.where(client: c1).empty?
  end

  def rand_number
    rand(99999).to_s
  end

end
