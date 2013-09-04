class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :ensure_clan_exists

  def create
    raise "Not an envato email" unless email.ends_with?("@envato.com")
    user = User.with_email(email) || User.create!(name: name, primary_email: email, emails: [ email ])

    clan = Clan.where(slug: params[:state]).first

    if clan.kinship_for_user(user).nil?
      Kinship.create!(clan: clan, user: user, role: "user")
    end

    session[:user_id] = user.id

    redirect_to "http://#{clan.slug}.#{SITE_ROOT}"
    # redirect_to root_url, notice: "Yay, <strong>#{user.name.split[0]}</strong>! You've successfully signed in to <strong>Hilander</strong>".html_safe
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "So long and thanks for all the fish! You've signed out"
  end

  private

  def name
    details['name']
  end

  def email
    details['email']
  end

  def details
    @details ||= request.env["omniauth.auth"]['info']
  end

end