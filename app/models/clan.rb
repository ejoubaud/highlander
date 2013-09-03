class Clan < ActiveRecord::Base
  has_many :kinships
  has_many :users, through: :kinships
end
