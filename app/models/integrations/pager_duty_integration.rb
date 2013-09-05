module Integrations
  class PagerDutyIntegration < Base
    attribute :api_key, String
    attribute :subdomain, String
  end
end