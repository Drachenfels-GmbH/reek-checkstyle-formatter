require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require 'reek-checkstyle-formatter/rake_task'
require 'fileutils'

RSpec::Core::RakeTask.new(:spec)

# make test task the gem task
task :default => :spec
task :spec => :clean

desc 'Remove generated files.'
task :clean do
  ['spec/reports', 'spec/coverage'].each do |path|
    FileUtils.rm_rf(path) if File.exists?(path)
  end
end