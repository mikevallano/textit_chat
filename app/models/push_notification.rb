class PushNotification < ActiveRecord::Base
  def self.push
    messages_sent = {}
    clients = Client.where(general_information_requested: true)

    all.each do |n|
      clients.each do |c|
        if c.push_notifications.where(id: n.id).blank? && !messages_sent[c.id]
          messages_sent[c.id] = true
          m = Message.new_push_notification(c.phone_number, n.message)
          if m.save
            SentPushNotification.create!(client: c, push_notification: n)
          end
        end
      end
    end
  end
end