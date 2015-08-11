class HealthProblem < ActiveRecord::Base
  include LocaleFilter
  def to_s
    name
  end
end