module PayloadAdapters

  class GithubPush < GithubBase

    def branch
      payload[:ref]
    end

    def github_username
      payload[:commits].first[:author][:username]
    end

  end

end
