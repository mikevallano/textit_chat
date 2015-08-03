class DiagnosedHealthProblem < ActiveRecord::Base
  include LocaleFilter
  belongs_to :health_problem
  belongs_to :client
end
