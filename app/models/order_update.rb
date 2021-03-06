class OrderUpdate < ActiveRecord::Base
  include LocaleFilter
  belongs_to :user
  belongs_to :order

  has_paper_trail

  def to_s
    confirmation_code
  end
end
