require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)
I18n.enforce_available_locales = false
module Kegup
  GIT_SHA = (ENV['GIT_REF'] || `git describe --always 2> /dev/null`).chomp
  START_TIME = Time.now

  class Application < Rails::Application
    # Precompile additional assets
    config.assets.precompile += %w(slate.css slate.js)

    # less-rails gem (default all generators)
    config.app_generators.stylesheet_engine :less

    console do
      require "pry"
      config.console = Pry
    end
  end
end
