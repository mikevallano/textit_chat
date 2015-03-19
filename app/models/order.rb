class Order < ActiveRecord::Base
  has_many :order_updates
  belongs_to :client
  before_save :set_default_state
  validates :subtotal, :shipping, :taxes,
    presence: true

  has_paper_trail

  @@STATE_NONE = "No orders requested"
  @@STATE_DEFAULT = "Pending payment confirmation"
  @@STATE_PAYMENT_CONFIRMED = "Payment confirmed"
  @@STATE_PERSCRIPTION_CONFIRMED = "Perscription confirmed"

  @@DEFAULT_SUBTOTAL = 100
  @@DEFAULT_SHIPPING = 0
  @@DEFAULT_TAXES = 0

  def confirm_perscription
    update(state: "Perscription filled") if pending_perscription?
  end

  def confirm_payment
    update(state: "Payment received") if pending_payment?
  end

  def assign_to_all_users
    User.all.each do |u|
      OrderUpdate.create! order: self, user: u
    end
  end

  def self.create_from_textit(params)
    client = Client.find_or_create_by(phone_number: params[:phone])

    client.orders.create!(
      subtotal: Order.DEFAULT_SUBTOTAL,
      shipping: Order.DEFAULT_SHIPPING,
      taxes:    Order.DEFAULT_TAXES
    )
  end

  def set_default_state
    self.state ||= Order.STATE_DEFAULT
  end

  def to_s
    "#{order_number} ($#{total})"
  end

  def order_number
    id.to_s.rjust(10, "0")
  end

  def total
    subtotal + shipping + taxes
  end

  def confirmation_code
    pending_payment? ?  state : order_updates.last
  end

  def pending_payment?
    state == Order.STATE_DEFAULT
  end

  def pending_perscription?
    state == Order.STATE_PAYMENT_CONFIRMED
  end

  def client_number
    client.phone_number
  end

  def product
    "TODO: PRODUCT NAME"
  end

  def self.STATE_NONE
    @@STATE_NONE
  end

  def self.STATE_DEFAULT
    @@STATE_DEFAULT
  end

  def self.STATE_PAYMENT_CONFIRMED
    @@STATE_PAYMENT_CONFIRMED
  end

  def self.STATE_PERSCRIPTION_CONFIRMED
    @@STATE_PAYMENT_CONFIRMED
  end

  def self.DEFAULT_SUBTOTAL
    @@DEFAULT_SUBTOTAL
  end

  def self.DEFAULT_SHIPPING
    @@DEFAULT_SHIPPING
  end

  def self.DEFAULT_TAXES
    @@DEFAULT_TAXES
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |order|
        csv << order.attributes.values_at(*column_names)
      end
    end
  end
end
