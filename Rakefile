require 'foodcritic'
require 'rake'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new
RuboCop::RakeTask.new
FoodCritic::Rake::LintTask.new

task default: %i[spec]
