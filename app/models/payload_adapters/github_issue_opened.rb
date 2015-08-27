module PayloadAdapters

  class GithubIssueOpened < GithubBase

    def github_username
      payload[:issue][:user][:login]
    end

    def action
      payload[:issue_action]
    end

  end

end
