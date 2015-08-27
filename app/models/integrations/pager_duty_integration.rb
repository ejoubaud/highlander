module Integrations
  class PagerDutyIntegration < Base
    attribute :api_key, String
    attribute :subdomain, String

    def execute
      since = Time.now.yesterday.strftime('%Y-%m-%d')

      pager_duty.resolved_log_entries({ since: since }).each do |log_entry|
        post_metric(:pager_duty_ack, log_entry)
      end
    end

    private

    def pager_duty
      @pager_duty ||= PagerDuty.new(api_key, subdomain)
    end
  end
end