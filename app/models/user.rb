class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable
  has_many :subscriptions
  has_many :chats, through: :subscriptions

  def unread_messages(chat)
    s = subscriptions.where(chat_id: chat.id).first
    start = s.last_read_at
    finish = Time.zone.tomorrow

    puts start
    puts finish
    chat.messages.where(:sent_at => start..finish)
  end

  def update_last_read(chat)
    s = subscriptions.where(chat_id: chat.id).first
    s.update!(last_read_at: Time.zone.now)
  end
end
