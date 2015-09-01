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

    it "allows for general redemptions" do
      validator = FactoryGirl.create(:unlimited_code_validator)
      code = FactoryGirl.create(:code, code_validator_id: validator.id)
      FactoryGirl.create_list(:code_usage, 10, code: code, client: FactoryGirl.create(:client))

      expect(validator.is_valid_code?(code)).to eq(true)
    end

    it "doesn't allow too many general redemptions" do
      validator = CodeValidator.create(max_redemptions: 1)
      code = Code.create(code_validator: validator)

      expect(validator.is_valid_code?(code)).to eq(true)
      CodeUsage.create(code: code)
      expect(validator.is_valid_code?(code)).to eq(false)
    end

    it "doesn't allow too many unique redemptions" do
      validator = FactoryGirl.create(:limited_code_validator, max_unique_redemptions: 1)
      code = FactoryGirl.create(:code, code_validator_id: validator.id)
      client = FactoryGirl.create(:client)

      expect(validator.is_valid_code?(code, client)).to eq(true)
      FactoryGirl.create(:code_usage, code: code, client: client)
      expect(validator.is_valid_code?(code, client)).to eq(false)
    end
  # end
end