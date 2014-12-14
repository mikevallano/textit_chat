class SentPushNotification < ActiveRecord::Base
  belongs_to :push_notification
  belongs_to :client
end
