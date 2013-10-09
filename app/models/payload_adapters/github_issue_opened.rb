module PayloadAdapters

  class GithubIssueOpened < GithubBase

    def github_username
      payload[:issue][:user][:login]
    end

    def action
      payload[:action]
    end

  end

end
