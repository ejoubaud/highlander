module UrlHelpers

  def api_endpoint(path, clan_slug = 'clan')
    "http://#{clan_slug}.#{SITE_ROOT}/api#{path}"
  end

end
