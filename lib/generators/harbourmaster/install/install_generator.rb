module Harbourmaster
  class InstallGenerator < Rails::Generators::Base
    desc 'Creates a base api controller from which all other controllers will inherit. Also generates the serializer initializer.'

    source_root File.expand_path('../templates', __FILE__)

    def copy_base_api_controller
      copy_file 'base_api_controller.rb', 'app/controllers/base_api_controller.rb'
    end

    def initializer_responder
      template 'json_responder.rb', 'lib/responders/json_responder.rb'
    end

    def initialize_active_model_serializers
      copy_file 'active_model_serializer.rb', 'config/initializers/active_model_serializer.rb'
    end

    def initialize_api_docs
      copy_file 'rspec_api_documentation.rb', 'config/initializers/rspec_api_documentation.rb'
    end

    def initialize_apitome
      generate "apitome:install"
    end
  end
end
