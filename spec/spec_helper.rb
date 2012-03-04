require 'rubygems'
require 'spork'

ENV["RAILS_ENV"] ||= 'test'

Spork.prefork do
  require "rails/application"
  require File.expand_path("../../config/environment", __FILE__)
  require "rspec/rails"
  require 'rspec/autorun'
  
  RSpec.configure do |config|
    config.mock_with :rspec
    config.expect_with :rspec
    
    #rspec colors and formatting
    config.color_enabled = true
    config.tty = true
    config.formatter = :documentation # :progress, :html, :textmate
    config.infer_base_class_for_anonymous_controllers = false
  end
end

Spork.each_run do
  [ "support/config/*.rb", "support/*.rb" ].each do |path|
    Dir["#{File.dirname(__FILE__)}/#{path}"].each do |file|
      require file
    end
  end
end