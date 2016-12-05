#
# Cookbook Name:: np-users
# Spec:: dotfiles
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'
require 'yaml'

describe 'np-users::dotfiles' do
  before do
    common_stubs

    @chef_run = memoized_runner(described_recipe)
  end

  subject { @chef_run }

  it { is_expected.to install_package 'cpio' }
  it { is_expected.to install_package 'git' }

  context 'for the user nick' do
    it do
      is_expected.to checkout_git('/home/nick/...').with(
        user: 'nick',
        repository: 'https://github.com/ingydotnet/...',
        enable_checkout: false
      )
    end

    it do
      is_expected.to create_file('/home/nick/.../conf').with(
        user: 'nick',
        group: 'nick',
        mode: '0644'
      )
    end
  end

  context 'with extra repos specified via attributes' do
    subject do
      memoized_runner(described_recipe, 'extra repos') do |node|
        node.override[:np_users][:dotfiles][:repos] = {
          'nick' => [
            {
              'repo' => 'https://github.com/nickpegg/dotfiles',
              'branch' => 'foo'
            }
          ]
        }
      end
    end

    it 'has all the repos in the dotdotdot config' do
      expected_config = {
        'dots' => [
          {
            'repo' => 'https://github.com/nickpegg/dotfiles',
            'branch' => 'foo',
            'path' => 'foo'
          },
          {
            'repo' => 'https://github.com/nickpegg/dotfiles'
          }
        ]
      }

      is_expected.to create_file('/home/nick/.../conf').with_content(expected_config.to_yaml)
    end
  end
end
