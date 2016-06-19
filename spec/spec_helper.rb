require 'chefspec'
require 'chefspec/berkshelf'

module SpecHelper
  @@runner = {} # rubocop:disable Style/ClassVars

  def stub_enc_data_bag(bag, item, contents = {})
    allow(Chef::EncryptedDataBagItem).to receive(:load).with(bag, item).and_return(contents)
  end

  def common_stubs # rubocop:disable Metrics/MethodLength
    stub_data_bag('users').and_return(%w(nick test1))
    stub_enc_data_bag(
      'users',
      'nick',
      'id' => 'nick',
      'dotfiles_repo' => 'https://github.com/nickpegg/dotfiles',
      'u2f_keys' => [
        'some_yubikey'
      ]
    )

    stub_enc_data_bag(
      'users',
      'test1',
      'id' => 'test1'
    )
  end

  def memoized_runner(recipe)
    @@runner[recipe] ||= begin
      runner = ChefSpec::SoloRunner.new
      runner.converge recipe
    end
  end
end

RSpec.configure do |config|
  config.include SpecHelper
end
