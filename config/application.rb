require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  # Bundler.require *Rails.groups(:assets => %w(development test))
  # If you want your assets lazily compiled in production, use this line
  Bundler.require(:default, Rails.env)

  # Allow .env variables to be available at boot time in Development
  if Rails.env == "development"
    Dotenv::Railtie.load
  end
end

# Note, .dev TLD won't be accepted by Google OAuth callbacks, you'll need
# something like hilanderlocal.com:3000 here and in your hosts file.
SITE_ROOT = ENV["HILANDER_ROOT"] || "hilanderlocal.com:3000"

module Highlander
  class Application < Rails::Application

    config.time_zone = 'Melbourne'
    config.active_record.observers = [ :event_observer, :achievement_observer, :bounty_observer ]

    #fonts path
    config.assets.paths << "#{Rails.root}/app/assets/fonts"

    #sass, beeeatch
    config.sass.preferred_syntax = :sass

    config.autoload_paths << File.join(Rails.root, 'lib')

    config.action_mailer.default_url_options = {
      host: SITE_ROOT,
    }

    default_url_options

    config.generators do |g|
      g.fixture_replacement :factory_girl
    end

    # config.cache_store = :dalli_store
    config.cache_store = :memory_store
  end
end