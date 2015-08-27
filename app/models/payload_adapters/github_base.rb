module PayloadAdapters

  class GithubBase < Base

    def user
      @user ||= Services::Github.find_by_username(github_username).try(:user)
    end

    # Gah, I hate this
    def payload=(payload)
      github_payload = JSON.parse(payload.delete(:payload)).to_h
      @payload = payload.merge!(github_payload)
    end

  end

end
