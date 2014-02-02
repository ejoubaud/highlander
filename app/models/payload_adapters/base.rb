module PayloadAdapters

  class Base

    delegate :validate!, to: :validator
    attr_accessor :clan

    def initialize(payload = {}, clan = nil)
      self.payload = payload
      self.clan = clan
    end

    def to_event_hash
      {
        user:    user,
        metric:  metric,
        value:   value || metric.default_unit,
        data:    data,
        kinship: kinship
      }
    end

    def to_s
      to_event_hash.to_s
    end

    def metric
      @meric ||= Metric.find_by_name(payload[:metric])
    end

    def user
      @user ||= User.with_email(payload[:email])
    end

    def kinship
      @kinship ||= clan.kinships.where(user_id: user.id).first
    end

    def data
      @data ||= payload.except(*ignored_payload_keys)
    end

    def request_ip_address
      @request_ip_address ||= IPAddr.new(payload[:request_ip_address])
    end

    private

    attr_accessor :payload

    def validator
      @validator ||= Factories::PayloadValidatorFactory.for(self)
    end

    def ignored_payload_keys
      [ 'controller', 'action', 'format' ]
    end

    def value
      nil
    end

  end

end
