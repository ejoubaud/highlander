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

  before_filter :ensure_clan_exists

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  protected

  def current_clan
    @current_clan ||= begin
      subdomain = Subdomain.extract_from_request(request)
      Rails.logger.info "Loading clan from slug: #{subdomain}"
      Clan.where(slug: subdomain).first
    end
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

  def ensure_clan_exists
    render_404 unless current_clan.present?
  end

  def render_404
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

  helper_method :current_user
  helper_method :unclaimed_bounties
  helper_method :signed_in?
  helper_method :current_clan

end
