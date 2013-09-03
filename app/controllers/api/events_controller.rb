module Api

  class EventsController < BaseController
    respond_to :json

    skip_before_filter  :verify_authenticity_token
    before_filter :validate_payload!

    def create
      if Event.create(payload.to_event_hash)
        code = :ok
      else
        code = :not_found
      end

      respond_to do |format|
        format.json { head code }
      end
    end

    private

    def validate_payload!
      Rails.logger.info "Payload: #{payload.inspect}"

      payload.validate!
    end

    def payload
      Rails.logger.info "Params: #{params.inspect}"
      @payload ||= Factories::PayloadAdapterFactory.for(params).tap { |payload| payload.clan = current_clan }
    end

  end

end
