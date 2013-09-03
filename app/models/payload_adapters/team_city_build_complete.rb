module PayloadAdapters

  class TeamCityBuildComplete < Base

    def user
      @user ||= User.find_by_name(triggered_by)
    end

    def triggered_by
      payload[:build][:triggeredBy]
    end

    def green?
      payload[:build][:buildResult] == "success"
    end

  end

end
