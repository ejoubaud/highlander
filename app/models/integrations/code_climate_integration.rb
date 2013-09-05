module Integrations
  class CodeClimateIntegration < Base
    attribute :app_id, String
    attribute :email, String
    attribute :password, String
    attribute :github_repo_name, String
    attribute :github_username, String
    attribute :github_password, String
  end
end