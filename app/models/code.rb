class Code < ActiveRecord::Base
  belongs_to :code_validator, inverse_of: :codes
  belongs_to :code_batch
  has_many :code_usages, inverse_of: :code

  before_save :generate_and_set_code

  private

  require 'securerandom'
  def generate_and_set_code
    self.code ||= SecureRandom.hex[0,6].upcase
  end
end
