module Services

  class GithubDecorator < BaseDecorator

    def url
      "//github.com/#{service.username}"
    end

  end

end
