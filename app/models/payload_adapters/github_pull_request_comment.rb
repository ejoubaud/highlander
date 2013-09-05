module PayloadAdapters

  class GithubPullRequestComment < Base

    def user
      @user ||= Services::Github.find_by_username(commenter_username).try(:user)
    end

    def commenter_username
      payload[:sender][:login]
    end

    def pull_request?
      # the Github issue_comment hook doesn't discriminate between issues and PRs
      payload[:comment][:pull_request_url] || payload[:issue].try(:[], :pull_request).try(:[], :html_url)
    end

  end

end
