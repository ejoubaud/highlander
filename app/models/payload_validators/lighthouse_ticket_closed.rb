module PayloadValidators

  class LighthouseTicketClosed < Base

    ENVATOS_CLOSED_STATES = %w{fixed invalid deployed}

    def validate!
      super
      valid = payload.is_a_ticket? && 
        payload.previous_state.present? && 
        payload.closed? && 
        ENVATOS_CLOSED_STATES.exclude?(payload.previous_state)
              
    
      raise Errors::TicketNotClosed.new(payload) unless valid
    end

  end

end
