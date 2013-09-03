require 'openid/fetchers'
OpenID.fetcher.ca_file = File.join(Rails.root,'config','curl.pem')
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_apps, domain: 'envato.com'
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
end
