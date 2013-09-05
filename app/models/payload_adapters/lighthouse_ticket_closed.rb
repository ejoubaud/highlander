module PayloadAdapters

  class LighthouseTicketClosed < Base

    def user
      @user ||= Services::Lighthouse.find_by_username(lighthouse_username).try(:user)
    end

    def lighthouse_username
      payload[:version][:assigned_user_name]
    end

    def closed?
      payload[:version][:closed] == 'true'
    end

  end

end
