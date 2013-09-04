Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_KEY"], ENV["GOOGLE_SECRET"], provider_ignores_state: true
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
end
