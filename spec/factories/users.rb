FactoryGirl.define do
  factory :user do
    nickname { SecureRandom.hex(10) }
    email { SecureRandom.hex(6) }
  end
end
