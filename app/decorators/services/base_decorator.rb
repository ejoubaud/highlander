module Services

  class BaseDecorator

    def initialize service
      @service = service
    end

    def setup?
      true
    end

    def handle
      service.username
    end

    def url
      raise NotImplementedError
    end

    private

    attr_reader :service
  end

end
