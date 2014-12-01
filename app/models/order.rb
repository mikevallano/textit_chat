class Order < ActiveRecord::Base
  has_many :order_updates
  belongs_to :client
  before_save :set_default_state
  validates :beneficiary_number, :subtotal, :shipping, :taxes,
    presence: true

  def confirm
    update(state: "Confirmed") if pending?
  end

  def set_default_state
    self.state ||= "Pending"
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
    pending? ?  "None" : order_updates.last
  end

  def pending?
    state == "Pending"
  end
end
