class Client < ActiveRecord::Base
  has_many :chats
  has_many :orders

  def chat
    chats.present? ? chats.first : chats
  end
end
