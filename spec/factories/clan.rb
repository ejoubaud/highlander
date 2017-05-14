# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :slug do |n|
    "clan#{n}"
  end

  factory :clan do
    name 'Clan name'
    slug
  end
end
