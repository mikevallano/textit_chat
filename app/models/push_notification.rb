class PushNotification < ActiveRecord::Base
  def self.push
    clients = Client.where(general_information_requested: true)

    all.each do |n|
      clients.each do |c|
        unless c.push_notifications.where(id: n.id)
          m = new_push_notification(c.phone_number, n.message)
          if m.save
            SentPushNotification.create(client: c, push_notification: n)
          end
        end
      end
    end
  end
end
