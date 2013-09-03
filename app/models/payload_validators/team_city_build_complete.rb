module PayloadValidators

  class TeamCityBuildComplete < Base

    def validate!
      super
      raise Errors::NotAGreenBuild.new(payload) unless payload.green?
    end

  end

end
