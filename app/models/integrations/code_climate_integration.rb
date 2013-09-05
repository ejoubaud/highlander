module Integrations
  class CodeClimateIntegration < Base
    attribute :app_id, String
    attribute :email, String
    attribute :password, String
    attribute :github_repo_name, String
    attribute :github_username, String
    attribute :github_password, String

    def execute
      account_info = CodeClimate::AccountInfo.new(
        app_id:   app_id,
        email:    email,
        password: password
      )

      scraper   = CodeClimate::Scraper.new(account_info)
      from_date = nil #DateTime.parse('1900-01-01')

      feed = CodeClimate::Feed.new(scraper, from_date)
      feed.update!

      github_client = Octokit::Client.new(login: github_username, password: github_password)

      # DAFUQ! Might be worth injecting the client and feed into a service to patch up authors
      feed.improvements.each do |entry|

        # get the comparison from GitHub
        comparison = github_client.compare(github_repo_name, entry.from_sha, entry.to_sha)

        authors   = comparison.commits.collect(&:author).compact.collect(&:login).uniq

        authors.each do |author|
          data = entry.to_h.merge(user: author)
          post_metric(:code_quality_improvement, data)
        end
      end

    end
  end
end