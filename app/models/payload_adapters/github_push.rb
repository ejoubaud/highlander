module PayloadAdapters

  class GithubPush < Base

    def user
      @user ||= Services::Github.find_by_username(username).try(:user)
    end

    def branch
      payload[:ref]
    end

    def username
      payload[:commits].first[:author][:username]
    end

    private

    # Gah, I hate this
    def payload=(payload)
      github_payload = JSON.parse(payload.delete(:payload)).to_h
      @payload = payload.merge!(github_payload)
    end

  end

end
