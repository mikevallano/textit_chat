class CodeUsage < ActiveRecord::Base
  belongs_to :code, inverse_of: :code_usages
  belongs_to :client
end
