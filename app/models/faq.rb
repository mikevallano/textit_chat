class Faq < ActiveRecord::Base
  include LocaleFilter
  has_paper_trail

  def to_s
    question
  end
end
