module PayloadValidators

  class ForumPost < Base

    def validate!
      super
      raise Errors::ForumPostAlreadyProcessed.new(payload) if already_attributed?
    end

    def already_attributed?
      Event.forum_posts.with_key_and_value('id', payload.id).present?
    end

  end

end