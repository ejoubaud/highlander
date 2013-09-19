module PayloadAdapters

  class Deploy < Base

    def user
      @user ||= begin
        if email.present?
          User.with_email(email)
        elsif github_username.present?
          Services::Github.find_by_username(github_username).try(:user)
        end 
      end
    end

    def github_username
      payload[:github_username]
    end

    def email
      payload[:email]
    end

  end

end

