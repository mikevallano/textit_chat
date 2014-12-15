class DiagnosedHealthProblem < ActiveRecord::Base
  belongs_to :health_problem
  belongs_to :client
end
