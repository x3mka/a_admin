# Rails template to build the sample app for specs

run "rm Gemfile"
run "rm -r test"
# run "rm -r spec"

# Create a cucumber database and environment
#copy_file File.expand_path('../templates/cucumber.rb', __FILE__),                "config/environments/cucumber.rb"
#copy_file File.expand_path('../templates/cucumber_with_reloading.rb', __FILE__), "config/environments/cucumber_with_reloading.rb"

gsub_file 'config/database.yml', /^test:.*\n/, "test: &test\n"
#gsub_file 'config/database.yml', /\z/, "\ncucumber:\n  <<: *test\n  database: db/cucumber.sqlite3"
#gsub_file 'config/database.yml', /\z/, "\ncucumber_with_reloading:\n  <<: *test\n  database: db/cucumber.sqlite3"

# home controller & routes
copy_file File.expand_path('../templates/app/controllers/home_controller.rb', __FILE__),           "app/controllers/home_controller.rb"
copy_file File.expand_path('../templates/app/views/home/index.html.erb', __FILE__),                "app/views/home/index.html.erb"
#generate :controller "home index --skip-assets"
inject_into_file "config/routes.rb", "  root 'home#index'\n", :after => "::Application.routes.draw do\n"

generate :model, "user type:string first_name:string last_name:string username:string age:integer"
inject_into_file 'app/models/user.rb', %q{

  def display_name
    "#{first_name} #{last_name}"
  end
}, :after => 'class User < ActiveRecord::Base'


# Configure default_url_options in test environment
inject_into_file "config/environments/test.rb", "  config.action_mailer.default_url_options = { :host => 'example.com' }\n", :after => "config.cache_classes = true\n"

# Add our local Active Admin to the load path
inject_into_file "config/environment.rb", "\n$LOAD_PATH.unshift('#{File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'lib'))}')\nrequire \"a_admin\"\n", :after => "require File.expand_path('../application', __FILE__)"

# Add some translations
#append_file "config/locales/en.yml", File.read(File.expand_path('../templates/en.yml', __FILE__))

# Add predefined admin resources
#directory File.expand_path('../templates/admin', __FILE__), "app/admin"

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

#generate :'a_admin:install'

rake "db:migrate"
rake "db:test:prepare"
#run "/usr/bin/env RAILS_ENV=cucumber rake db:migrate"




