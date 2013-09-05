module PayloadAdapters

  class GithubPullRequestComment < Base

    def user
      @user ||= Services::Github.find_by_username(commenter_username).try(:user)
    end

    def commenter_username
      # payload[:comment][:user][:login]
      'ejoubaud'
    end

    def opener_username
      # payload[:commits].first[:author][:username]
    end

  end

end
