class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :subscriptions
  has_many :chats, through: :subscriptions
  has_many :order_updates
  has_many :orders, through: :order_updates

  def unread_messages(chat)
    s = subscriptions.where(chat_id: chat.id).first
    start = s.last_read_at
    finish = Time.zone.tomorrow

    chat.messages.where(:sent_at => start..finish)
  end

  def update_last_read(chat)
    s = subscriptions.where(chat_id: chat.id).first
    s.update!(last_read_at: Time.zone.now)
  end

  def self.subscribe_all(chat)
    all.each do |user|
      user.subscribe_to chat
    end
  end

  def subscribe_to(chat)
    Subscription.where(user: self, chat:chat).first_or_create!
  end

  def is_admin?
    is_admin
  end
end
