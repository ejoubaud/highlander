module PayloadAdapters

  class ForumPost < Base

    def user
      @user ||= Services::Envato.find_by_username(forum_username).try(:user)
    end

    def id
      payload[:post_id]
    end

    def forum_username
      payload[:username]
    end

  end

end