class Chat < ActiveRecord::Base
  has_many :messages
  has_many :subscriptions

  def most_recent_message_time
     m = messages.order("sent_at DESC").first
     m ? m.sent_at : 10.years.ago
  end
end
