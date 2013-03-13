if ENV['COVERAGE_REPORT']
  require 'simplecov'
  require 'simplecov-rcov'
  SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
  SimpleCov.coverage_dir 'reports'
  SimpleCov.adapters.define 'Library' do
    load_adapter 'rails'
    add_filter '/config/'
    add_filter '/db/'
    add_filter '/features/'
    add_filter '/locales/'
    add_filter '/script/'
    add_filter '/spec/'
  end
  SimpleCov.start 'Library'
end
# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|

  config.exclusion_filter = { :slow_tests => false}
  def create(name)
    post :create, {:isbn => "9781934356371"}
  end

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_base_class_for_anonymous_controllers = false

  config.order = "random"
end
