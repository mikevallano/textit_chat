class Faq < ActiveRecord::Base
  has_paper_trail

  def to_s
    question
  end
end
