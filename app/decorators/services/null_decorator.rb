module Services

  NullDecorator = Naught.build do |config|
    config.mimic BaseDecorator

    def setup?
      false
    end
  end

end
