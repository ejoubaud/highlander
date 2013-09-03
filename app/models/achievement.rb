class Achievement < ActiveRecord::Base

  belongs_to :user
  belongs_to :kinship
  belongs_to :badge

  delegate :name, to: :badge, prefix: true

  def users
    kinships = Kinship.where(clan_id: kinship.clan_id).select("id")
    achievements = Achievement.where("kinship_id IN (#{kinships.to_sql})").where(badge_id: badge_id).select("user_id")
    User.where("id IN (#{achievements.to_sql})")
  end

end
