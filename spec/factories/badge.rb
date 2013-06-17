FactoryGirl.define do

  factory :badge do

    factory :first_time do
      name          'first_time'
      tag           'Experience the quickening'
      description   'First timer'
    end

    trait :hipster do
      name          'hipster'
      tag           "You're so not mainstream"
      description   'Hipster'
    end

    factory :one_twitter_mention do
      name          '1_twitter_mention'
      tag           'Fly fly little birdie!'
      description   'First Twitter mention'
    end

  end
end
