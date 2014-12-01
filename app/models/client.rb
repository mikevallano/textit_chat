class Client < ActiveRecord::Base
  has_many :chats
  has_many :orders

  def chat
    chats.present? ? chats.first : chats
  end

  def state
    orders.present? ? orders.first.state : "No orders requested"
  end

  def to_s
    phone_number
  end
end
