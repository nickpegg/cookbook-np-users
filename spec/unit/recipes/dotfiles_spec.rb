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

  it { is_expected.to install_package 'python' }
  it { is_expected.to install_python_pip 'dotfiles' }

  context 'for the user nick' do
    it do
      is_expected.to sync_git('/home/nick/.dotfiles').with(
        user: 'nick',
        group: 'nick',
        repository: 'https://github.com/nickpegg/dotfiles',
        reference: 'master'
      )
    end
  end
end
