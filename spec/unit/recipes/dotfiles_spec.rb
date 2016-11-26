#
# Cookbook Name:: np-users
# Spec:: dotfiles
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

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
end
