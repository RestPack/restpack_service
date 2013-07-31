require 'rake/testtask'

task :default => :test
task :test => :spec

begin
  require "rspec/core/rake_task"

  desc "Run all specs"
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = ['-cfs']
  end
rescue LoadError
end
