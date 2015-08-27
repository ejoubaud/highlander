module PayloadAdapters

  class GithubPullRequestComment < GithubBase

    def github_username
      payload[:sender][:login]
    end

    def pull_request?
      # the Github issue_comment hook doesn't discriminate between issues and PRs
      payload[:comment][:pull_request_url] || payload[:issue].try(:[], :pull_request).try(:[], :html_url)
    end

  end

end
