class CodeUsage < ActiveRecord::Base
  belongs_to :code
  belongs_to :client
  belongs_to :code_validator

  scope :client_usages, ->(client) { where(client: client) }
  # scope :usages -> (client, validator) {where(client: client, code_validator: validator)}

end
