#!/usr/bin/env rake
require 'rspec/core/rake_task'
require 'cucumber/rake/task'
require File.expand_path('../config/application', __FILE__)

RSpec::Core::RakeTask.new(:tests) do |t|
  t.rspec_opts = ""
end

Cucumber::Rake::Task.new(:tests) do |t|
  t.cucumber_opts = ""
end

task :default => :tests


Library::Application.load_tasks
