module UsersHelper

  def display_github_link?
    current_user == @user && !@user.github.setup?
  end

  def profile_subtitle
    lines = []
    lines << link_to(sanitize(@user.twitter.handle), sanitize(@user.twitter.url), target: '_blank') if @user.twitter.setup?
    lines << link_to('Link your Github Account', "/auth/github?redirect_uri=#{callback_for_github_oauth_uri}") if display_github_link?
    unless lines.empty?
      subtitle = lines.join(' - ').html_safe
      content_tag(:h3, subtitle, class: 'profile-subtitle')
    end
  end

end
