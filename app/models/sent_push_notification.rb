class SentPushNotification < ActiveRecord::Base
  include LocaleFilter
  belongs_to :push_notification
  belongs_to :client
end
