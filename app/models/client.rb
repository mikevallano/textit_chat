class Client < ActiveRecord::Base
  has_many :chats
  has_many :orders

  def chat
    chats.present? ? chats.first : chats
  end

  def state
    orders.present? ? orders.first.state : Order.STATE_NONE
  end

  def to_s
    phone_number
  end
end
