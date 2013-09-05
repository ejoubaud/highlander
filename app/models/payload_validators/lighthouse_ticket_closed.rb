module PayloadValidators

  class LighthouseTicketClosed < Base

    def validate!
      super
      raise Errors::TicketNotClosed.new(payload) unless payload.closed?
    end

  end

end
