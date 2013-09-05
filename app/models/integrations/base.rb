module Integrations
  class Base
    include Virtus

    attr_reader :current_clan

    def self.display_name
      if name =~ /Integrations::(.*)Integration/
        $1.to_s
      else
        name
      end
    end

    def self.configuration_options
      self.attribute_set
    end

    def configure(clan, options)
      @current_clan = clan

      options.each do |key, value|
        self.send("#{key}=", value)
      end
    end

    def clan_host
      clan_uri.host
    end

    def clan_port
      clan_uri.port
    end

    def clan_uri
      raise RuntimeError, "Integration has not been configured" if current_clan.nil?
      URI.parse("http://#{current_clan.slug}.#{SITE_ROOT}")
    end

    def post_metric(metric_name, data)
      uri = clan_metric_endpoint(metric_name)

      req = Net::HTTP::Post.new(uri.path, initheader = { 'Content-Type' =>'application/json' })
      req.body = data.to_json
      Net::HTTP.new(uri.host, uri.port).start { |http| http.request(req) }
    end

    def clan_metric_endpoint(metric_name)
      clan_uri.merge("/api/#{metric_name}.json")
    end

  end
end