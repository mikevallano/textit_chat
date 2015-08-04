class FollowUpQuestion < ActiveRecord::Base
  include LocaleFilter
  def to_s
    question
  end
end
