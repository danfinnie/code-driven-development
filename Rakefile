$:.unshift(File.dirname(__FILE__) + '/../../lib')

require 'bundler/gem_tasks'
require 'cucumber/rake/task'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)
Cucumber::Rake::Task.new

task default: [:spec, :cucumber]
