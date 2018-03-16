require 'chefspec'
require 'chefspec/berkshelf'

module SpecHelper
  @@runner = {} # rubocop:disable Style/ClassVars

  def common_stubs # rubocop:disable Metrics/MethodLength
    stub_data_bag('users').and_return(%w[nick test1])
    stub_data_bag_item('users', 'nick').and_return(
      'id' => 'nick',
      'dotfiles_repos' => [
        { 'repo' => 'https://github.com/nickpegg/dotfiles' }
      ],
      'u2f_keys' => [
        'some_yubikey'
      ]
    )

    stub_data_bag_item('users', 'test1').and_return('id' => 'test1')

    stub_command(
      ".../... super_update 2>&1 | grep -E '(^Cloning into|^Fast-forward)'"
    ).and_return false
  end

  def memoized_runner(recipe, name = '', options = {})
    options[:platform] ||= 'ubuntu'
    options[:version] ||= '16.04'

    @@runner[recipe + ' ' + name] ||= begin
      runner = ChefSpec::SoloRunner.new options
      yield runner.node if block_given?
      runner.converge recipe
      runner
    end
  end
end

RSpec.configure do |config|
  config.include SpecHelper
end
