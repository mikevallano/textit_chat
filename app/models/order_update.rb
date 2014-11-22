class OrderUpdate < ActiveRecord::Base
  belongs_to :user
  belongs_to :order

  def to_s
    confirmation_code
  end
end
