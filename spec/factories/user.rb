FactoryGirl.define do

  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user do
    name 'Bob Smith'
    email
    earns_points true

    trait :tweeter do
      after(:create) do |user, evaluator|
        FactoryGirl.create_list(:twitter_service, 1, user: user)
      end
    end

  end
end
