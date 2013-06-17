FactoryGirl.define do

  factory :metric do
    default_unit 1

    factory :twitter_mention do
      name          'twitter_mention'
      description   'Twitter mention'
      default_unit  2
    end

  end

end
