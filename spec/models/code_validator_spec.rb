require 'rails_helper'

RSpec.describe CodeValidator, type: :model do
  # context 'a code is created for a specific validator' do
  #   before(:context) do
  #   end

    it "only validates codes that belong to it" do
      validator = FactoryGirl.create(:code_validator)
      code = FactoryGirl.create(:code, code_validator_id: validator.id)
      expect(validator.is_valid_code?(code)).to eq(true)
    end

    it "allows for unlimited redemptions" do
      validator = FactoryGirl.create(:unlimited_code_validator)
      code = FactoryGirl.create(:code, code_validator_id: validator.id)
      FactoryGirl.create_list(:code_usage, 10, code: code)

      expect(validator.is_valid_code?(code)).to eq(true)
    end

    it "doesn't allow too many redemptions" do
      validator = FactoryGirl.create(:limited_code_validator, max_redemptions: 1)
      code = FactoryGirl.create(:code, code_validator_id: validator.id)
      FactoryGirl.create_list(:code_usage, 2, code: code)

      expect(validator.is_valid_code?(code)).to eq(false)
    end
  # end
end