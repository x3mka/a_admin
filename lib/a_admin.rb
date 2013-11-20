require 'a_admin/version'

require 'sass-rails'
require 'bootstrap-sass'

require 'devise'

module AAdmin
  class Engine < ::Rails::Engine
    isolate_namespace AAdmin
    engine_name :a_admin

    initializer 'a_admin.assets.paths' do |app|
      config.assets.paths << Rails.root.join('assets/templates')
    end

    initializer 'a_admin.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper AAdmin::ThemeHelper
      end
    end

  end
end
