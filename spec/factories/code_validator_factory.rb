FactoryGirl.define do
  factory :code_validator do

    max_redemptions -1
    max_unique_redemptions -1
    factory :unlimited_code_validator do
    end

    factory :limited_code_validator do
      max_redemptions { rand 0..100 }
      max_unique_redemptions { rand 0..100 }
    end
  end
end