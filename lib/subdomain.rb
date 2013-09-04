class Subdomain
  def self.extract_from_request(request)
    current_root = if request.port == 80
      request.host
    else
      "#{request.host}:#{request.port}"
    end

    extract_from_root(current_root)
  end

  def self.extract_from_root(root)
    subdomain_portion = root.sub(SITE_ROOT, "")
    if subdomain_portion.ends_with?(".")
      subdomain_portion[0..-2] 
    else
      subdomain_portion
    end
  end

  class Missing
    def self.matches?(request)
      subdomain = Subdomain.extract_from_request(request)
      return subdomain.blank? || subdomain == "www"
    end
  end

  class Present
    def self.matches?(request)
      !Missing.matches?(request)
    end
  end
end