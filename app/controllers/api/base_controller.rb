module Api

  class BaseController < ApplicationController
    protect_from_forgery with: :null_session

    before_filter :merge_request_ip_address_into_params!
    before_filter :merge_github_action_from_raw_params!

    def merge_request_ip_address_into_params!
      params.merge!(request_ip_address: request_ip_address)
    end

    def merge_github_action_from_raw_params!
      params.merge!(issue_action: request.request_parameters[:action])
    end

    def request_ip_address
      env['HTTP_X_FORWARDED_FOR'] || env['HTTP_X_REAL_IP'] || env['REMOTE_ADDR']
    end

    rescue_from Errors::UserNotFound do
      render text: "User is not authorised", status: :unauthorized
    end

    rescue_from Errors::UserNotPointEarner do
      render text: "User is not a point earner", status: :unauthorized
    end

    rescue_from Errors::InvalidMetric do
      render text: "Metric '#{payload.metric.try(:name)}' is invalid", status: :error
    end

    rescue_from Errors::InvalidRequestSource do
      render text: "You are not authorised", status: :error
    end

    rescue_from Errors::InvalidGitBranch do
      # Render a HTTP 200 even though it's invalid so we don't annoy Github
      Rails.logger.info "Not processing Github push for '#{payload.email}' as it's for branch: '#{payload.branch}'"
      render text: '', status: :ok
    end

    rescue_from Errors::TweetInvalid do
      Rails.logger.info "Not persisting tweet '#{payload.tweet_id}' for '#{payload.twitter_username}' as it's invalid"
      render text: 'Tweet invalid', status: :error
    end

    rescue_from Errors::TweetAlreadyProcessed do
      Rails.logger.info "Not persisting tweet '#{payload.tweet_id}' for '#{payload.twitter_username}' as it's already been processed"
      render text: 'Tweet already processed', status: :ok
    end

    rescue_from Errors::PagerDutyAckAlreadyProcessed do
      Rails.logger.info "Not persisting PagerDuty ack '#{payload.ack_id}' for '#{payload.email}' as it's already been processed"
      render text: 'PagerDuty ack already processed', status: :ok
    end

    rescue_from Errors::PingPongWinnerAlreadyProcessed do
      Rails.logger.info "Not awarding points for Ping Pong win. Match: '#{payload.match_id}' for '#{payload.twitter_username}' as it's already been processed"
      render text: 'Match already processed', status: :ok
    end

    rescue_from Errors::IssueActionNotOpened do
      render text: 'Github issue action was not an open event', status: :ok
    end

    rescue_from Errors::IssueActionNotClosed do
      render text: 'Github issue action was not a close event', status: :ok
    end
    
    rescue_from Errors::TicketNotClosed do
      render text: 'Lighthouse ticket did not meet closed condition, so was not counted', status: :ok
    end

    recuse_from Errors::InvalidTicket do
      render text: 'Lighthouse ticket was not valid', status: :ok
    end

    rescue_from Errors::CodeQualityImprovementAlreadyProcessed do
      Rails.logger.info "Not awarding points for Code Quality Improvement. Id: '#{payload.id}' for '#{payload.github_username}' as it's already been processed"
      render text: 'Improvement already processed', status: :ok
    end

  end

end
