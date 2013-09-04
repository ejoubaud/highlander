class Clan < ActiveRecord::Base
  has_many :kinships
  has_many :users, through: :kinships

  def kinship_for_user(user)
    if user.new_record?
      nil
    else
      kinships.where(user_id: user.id).first
    end
  end
end
