module Harbourmaster
  class ControllerGenerator < Rails::Generators::NamedBase
    desc 'Used to create a documented API controller'
    argument :api_base_route, type: :string, default: "app/controllers/api"
    class_option :permit_params, type: :boolean, desc: "When included will generate a permitted_params method in the controller"
    class_option :skip_tests, type: :boolean, desc: "Skip generating the acceptance tests used for generating documentation"
    class_option :actions, type: :array, aliases: '-a', desc: "List of controller actions to generate"
    source_root File.expand_path('../templates', __FILE__)\

    def create_controller_file
      template 'controller.rb', "#{api_base_route}/#{plural_name}_controller.rb"
    end

    def create_acceptance_tests
      return if options['skip_tests']
      template 'acceptance_tests.rb', "spec/acceptance/#{plural_name}_spec.rb" if options['actions']
    end

    def create_serializer
      template 'serializer.rb', "app/serializers/#{name.underscore}_serializer.rb"
    end
  end
end
