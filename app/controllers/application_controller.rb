class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Workaround for Strong Params & CanCan bug - https://github.com/ryanb/cancan/issues/835
  #
  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  protected

  def current_clan
    subdomain = if request.domain =~ /(.*)\.localhost/
      $1
    else
      request.subdomain
    end

    Clan.where(slug: subdomain).first
  end

  def current_user
    @current_user ||= current_clan.users.find(session[:user_id]) if signed_in?
  rescue
    nil
  end

  def signed_in?
    session[:user_id].present?
  end

  def unclaimed_bounties
    Bounty.for_clan(current_clan).unclaimed.count
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, current_clan)
  end


  helper_method :current_user
  helper_method :unclaimed_bounties
  helper_method :signed_in?
  helper_method :current_clan

end
