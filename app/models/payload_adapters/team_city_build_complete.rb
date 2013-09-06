module PayloadAdapters

  class TeamCityBuildComplete < Base

    def user
      @user ||= Services::Github.find_by_username(triggered_by).try(:user)
    end

    def triggered_by
      payload[:build_triggered_by]
    end

    def green?
      payload[:build_result] == "success"
    end

  end

end
