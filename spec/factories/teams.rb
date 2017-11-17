FactoryGirl.define do
  factory :team do
    name { SecureRandom.hex(10) }
  end
end
