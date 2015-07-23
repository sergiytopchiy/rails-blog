FactoryGirl.define do
  factory :comment do
    body { Faker::Lorem.sentence(3) }
    article
    user
  end
end
