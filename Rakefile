require 'cookstyle'
require 'rubocop/rake_task'
require 'rspec/core/rake_task'

task default: [:cookstyle, :spec]
task all: [:default, :kitchen]

RuboCop::RakeTask.new(:cookstyle) do |task|
  task.options << '--display-cop-names'
end

RSpec::Core::RakeTask.new(:spec)

desc 'Run Kitchen tests'
task :kitchen do
  sh 'kitchen test'
end
