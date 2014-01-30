require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Kegup
  class Application < Rails::Application
    # Precompile additional assets
    config.assets.precompile += %w(slate.css slate.js)

    # less-rails gem (default all generators)
    config.app_generators.stylesheet_engine :less
  end
end
