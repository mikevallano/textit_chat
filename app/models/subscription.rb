class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :chat

  before_create :set_last_read_at

  def set_last_read_at
    self.last_read_at = 10.years.ago
  end
end
