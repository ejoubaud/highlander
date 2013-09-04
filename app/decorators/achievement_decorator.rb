class AchievementDecorator < Draper::Decorator

  alias :achievement :source
  delegate_all

  include ActionView::Helpers::DateHelper

  def description
    achievement.description.blank? ? badge.description : badge.description
  end

  def tag
    achievement.tag.blank? ? achievement.badge.tag : achievement.tag.truncate(70, separator: ' ', omission: '…')
  end

  def badge_takeup
    count = (achievement.badge_takeup - 1)

    if count == 0 || achievement.badge.is_hipster_badge? || achievement.badge.is_bounty_badge?
      'The only Hilander with this badge!'
    else
      possession = count == 1 ? 'has' : 'have'
      h.pluralize(count, 'other Hilander') << " #{possession} this badge"
    end
  end

  def created_at
    time_ago_in_words(achievement.created_at).capitalize
  end

end
