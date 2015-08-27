module Services

  class TwitterDecorator < BaseDecorator

    def handle
      '@' << service.username
    end

    def url
      "//twitter.com/#{service.username}"
    end

  end

end
