require 'opensesame-github'

module OpenSesame
  class Engine < ::Rails::Engine
    isolate_namespace OpenSesame

    config.generators do |g|
      g.test_framework :rspec, :view_specs => false
    end

    ActiveSupport.on_load(:action_controller) do
      include OpenSesame::ControllerHelper
    end

    ActiveSupport.on_load(:action_view) do
      include OpenSesame::ViewHelper
    end

    initializer "opensesame.middleware", :after => :load_config_initializers do |app|
      OpenSesame.configuration.validate!

      OpenSesame::Github.organization_name = OpenSesame.organization_name

      middleware.use OmniAuth::Builder do
        configure do |config|
          config.path_prefix = '/auth'
          config.full_host = OpenSesame.full_host if OpenSesame.full_host
        end

        provider :github, OpenSesame.github_client[:id], OpenSesame.github_client[:secret]
      end

      if defined?(Devise)
        Devise.setup do |config|
          config.warden do |manager|
            manager.default_strategies(:opensesame_github, :scope => :opensesame)
            manager.failure_app = OpenSesame::FailureApp.new
          end
        end
      else
        app.config.middleware.use Warden::Manager do |manager|
          manager.default_strategies(:opensesame_github, :scope => :opensesame)
          manager.failure_app = lambda { |env| OpenSesame::SessionsController.action(:new).call(env)}
        end
      end

    end
  end
end
