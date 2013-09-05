class BountyObserver < ActiveRecord::Observer

  def after_save bounty
    if bounty.claimed?
      kinship = bounty.clan.kinship_for_user(bounty.claimed_by)
      Event.create(metric: metric, kinship: kinship, user: bounty.claimed_by, value: bounty.reward, data: { tag: bounty.name })
    end
  end

  private

  def metric
    Metric.find_by_name('bounty')
  end
end
