module Factories

  class PayloadAdapterFactory

    def self.for(payload, clan)
      "PayloadAdapters::#{payload[:metric].camelize}".constantize.new(payload, clan)
    rescue NameError
      PayloadAdapters::Base.new(payload, clan)
    end

    private_class_method :new

  end

end
