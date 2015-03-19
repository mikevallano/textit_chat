class Client < ActiveRecord::Base
  has_many :chats
  has_many :orders
  has_many :sent_push_notifications
  has_many :push_notifications, through: :sent_push_notifications
  has_many :diagnosed_health_problems
  has_many :health_problems, through: :diagnosed_health_problems

  accepts_nested_attributes_for :diagnosed_health_problems
  accepts_nested_attributes_for :health_problems

  has_paper_trail

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

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |client|
        csv << client.attributes.values_at(*column_names)
      end
    end
  end
end
