class Kinship < ActiveRecord::Base
  belongs_to :user
  belongs_to :clan

  has_many :events,       -> { order 'events.created_at DESC' }
  has_many :metrics,      -> { order 'events.created_at DESC' }, through: :events
  has_many :achievements, -> { order 'achievements.created_at DESC' }
  has_many :badges,       -> { order 'achievements.created_at DESC' }, through: :achievements

  before_create :set_role_to_user

  def self.for_clan(clan)
    where(clan_id: clan)
  end

  def badge_count
    @total_badges ||= achievements.count
  end  

  def running_score
    events.where('created_at > ?', 1.weeks.ago.to_s(:db)).sum(:value)
  end

  def total_score
    @total_score ||= events.sum(:value)
  end


  private


  def set_role_to_user
    self.role = 'user' unless self.role
  end
end