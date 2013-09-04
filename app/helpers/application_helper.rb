module ApplicationHelper

  def badge_image_url badge
    asset_path("badges/#{badge.name}.png") if badge
  end

  def unclaimed_bounties_text
    "Bounties ".html_safe <<
    ((unclaimed_bounties > 0) ? content_tag(:span, unclaimed_bounties, class: 'count') : nil)
  end

  def organisation_url org
    "http://#{org}.#{request.env['HTTP_HOST'].gsub(/www\./, '')}"
  end

  def callback_for_google_oauth_uri
    if SITE_ROOT =~ /localhost/
      "http://#{SITE_ROOT}/auth/google_oauth2/callback"
    else
      "http://www.#{SITE_ROOT}/auth/google_oauth2/callback"
    end
  end
end
