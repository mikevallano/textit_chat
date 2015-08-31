class CodeUsage < ActiveRecord::Base
  belongs_to :code
  belongs_to :client
end
