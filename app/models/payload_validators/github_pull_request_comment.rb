module PayloadValidators

  class GithubPullRequestComment < Base

    def validate!
      super
      raise Errors::NonPullRequestIssueComment.new(payload) unless payload.pull_request?
    end

  end

end
