class CodeValidator < ActiveRecord::Base
  has_many :codes
  has_many :code_usages, through: :codes

  def is_valid_code?(code)
    !reached_max_redemptions? && validator?(code)
  end

  # Return true if the validator has processed too many redemptions
  # set to -1 if unlimited allowed
  def reached_max_redemptions?
    self.max_redemptions != -1 &&
    code_usages.size >= self.max_redemptions
  end

  # Return true if validator has processed too many redemptions from a specific client
  # set to -1 if unlimited allowed
  def reached_max_unique_redemptions?(code)
    self.max_unique_redemptions != -1 &&
    code_usages.client_usages(code.client).size >= self.max_unique_redemptions(code)
  end

  # Returns true if CodeValidator assigned to code
  def validator?(code)
    code.code_validator == self
  end

end
