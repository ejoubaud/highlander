module PayloadAdapters

  class GithubPush < Base

    def user
      @user ||= User.with_email(author_email)
    end

    def branch
      payload[:ref]
    end

    def author_email
      payload[:commits].first[:author][:email]
    end

    private

    def payload=(payload)
      github_payload = JSON.parse(payload.delete(:payload)).to_h
      @payload = payload.merge!(github_payload)
    end

  end

end
