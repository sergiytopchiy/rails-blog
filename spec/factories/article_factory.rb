FactoryGirl.define do
  factory :article do
    title { Faker::Internet.password(5) }
    text { Faker::Lorem.sentence(3) }
    user
    transient do
      comments_count 0
    end

    after(:create) do |article, evaluator|
      create_list(:comment, evaluator.comments_count, article: article) if evaluator.comments_count > 0
    end
  end
end
