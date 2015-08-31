require 'rails_helper'

RSpec.describe Code, type: :model do
  it 'generates codes as 6 alphanumeric random characters' do
    code1 = Code.create
    expect(code1.code).to match(/^\w{6}$/)

    code2 = Code.create
    expect(code2.code).to match(/^\w{6}$/)

    expect(code1.code).not_to eq(code2.code)
  end

  it 'doesnt override existing codes' do
    code1 = Code.create
    code1code = code1.code
    code1.save
    expect(code1.code).to eq(code1code)
  end
end
