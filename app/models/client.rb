class Client < ActiveRecord::Base
  has_many :chats
  has_many :orders
  has_many :sent_push_notifications
  has_many :push_notifications, through: :sent_push_notifications

  def chat
    chats.present? ? chats.first : chats
  end

  def state
    orders.present? ? orders.first.state : Order.STATE_NONE
  end

  def to_s
    phone_number
  end

  def self.register_for_general_info(params)
    client_num = params[:phone]
    if client_num.present?
      client = Client.find_or_create_by(phone_number: client_num)

      client.update_attributes general_information_requested: true
    end
  end
end
