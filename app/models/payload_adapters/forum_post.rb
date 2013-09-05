module PayloadAdapters

  class ForumPost < Base

    def user
      @user ||= Services::Envato.find_by_username(envato_username).try(:user)
    end

    def id
      payload[:id]
    end

    def envato_username
      payload[:user]
    end

  end

end