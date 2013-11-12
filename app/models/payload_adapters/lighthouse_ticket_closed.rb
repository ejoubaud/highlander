module PayloadAdapters

  class LighthouseTicketClosed < Base

    def user
      @user ||= Services::Lighthouse.find_by_username(lighthouse_username).user
    rescue
      raise Errors::UserNotFoundButThatsOk.new(payload)
    end

    def lighthouse_username
      payload[:version][:assigned_user_name]
    rescue StandardError 
      raise Errors::InvalidTicket.new(payload) 
    end

    def closed?
      payload[:version][:closed]
    end

    def is_a_ticket?
      payload[:version].present?
    end

    def previous_state
      payload[:version][:diffable_attributes].try(:[], :state)
    end
  end

end
