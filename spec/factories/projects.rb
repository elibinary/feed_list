FactoryGirl.define do
  factory :project do
    name { SecureRandom.hex(10) }
  end
end
