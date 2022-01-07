require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Listonymous
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.active_job.queue_adapter = :sidekiq

    Sidekiq.configure_server { |c| c.redis = { url: ENV['REDIS_URL'] } }

        # We want to set up a custom logger which logs to STDOUT.
    # Docker expects your application to log to STDOUT/STDERR and to be ran
    # in the foreground.
    config.log_level = :debug
    config.log_tags  = [:subdomain, :uuid]
    config.logger    = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))

    # Since we're using Redis for Sidekiq, we might as well use Redis to back
    # our cache store. This keeps our application stateless as well.
    # config.cache_store = :redis_store, ENV['CACHE_URL'],
    #                      { namespace: 'drkiq::cache' }

    # Don't generate system test files.
    config.generators.system_tests = nil
  end
end
