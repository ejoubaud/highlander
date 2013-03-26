class Api::Adapters::GithubController < Api::AdapterController

  MASTER_GIT_BRANCH = 'refs/heads/master'

  class InvalidGitBranch < RuntimeError ; end

  rescue_from InvalidGitBranch do
    # Render a HTTP 200 even though it's invalid so we don't annoy Github
    Rails.logger.info "Not processing Github push for '#{email}' as it's for '#{git_branch}'"
    render text: '', status: :ok
  end

  before_filter :validate_request_source, :validate_master_branch

  def create
    if new_event_for_user(metric)
      code = :ok
    else
      code = :not_found
    end

    respond_to do |format|
      format.json { head code }
    end
  end

  protected

  def current_user
    @current_user ||= User.with_email(email)
  end

  private

  def valid_metrics
    %w{ github_push }
  end

  def valid_request_sources
    %w{
      127.0.0.1/32
      207.97.227.253/32
      50.57.128.197/32
      108.171.174.178/32
      50.57.231.61/32
      204.232.175.64/27
      192.30.252.0/22

    }.map do |ip|
     IPAddr.new(ip).to_range
    end
  end

  def validate_master_branch
    raise InvalidGitBranch unless git_branch == MASTER_GIT_BRANCH
  end

  def payload
    JSON.parse(params[:payload])
  end

  def git_branch
    payload['ref']
  end

  def email
    payload['commits'].first['author']['email']
  end

  def metric_name
    'github_push'
  end

  def metric
    Metric.where(name: metric_name).first
  end

end
