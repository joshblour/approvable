require 'approvable/acts_as_approvable'
require 'aasm'
require 'activesupport/json_encoder'
require 'amoeba'

module Approvable
  cattr_accessor :disabled, :validate_with_changes
  disabled = false
  validate_with_changes = false  
  
  class Engine < ::Rails::Engine
    isolate_namespace Approvable

    initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end
    
    
    config.generators do |g|
      g.test_framework      :rspec,        :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper false
    end

  end
end
