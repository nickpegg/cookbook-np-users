#
# Cookbook Name:: np-users
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'np-users::u2f_keys' do
  before do
    common_stubs

    @chef_run = memoized_runner(described_recipe)
  end

  subject { @chef_run }

  let(:base_dir) { '/home/nick/.config/Yubico' }

  it { is_expected.to create_directory(base_dir).with(
    owner: 'nick',
    group: 'nick'
  ) }

  it { is_expected.to create_file(::File.join(base_dir, 'u2f_keys')).with(
    owner: 'nick',
    group: 'nick',
    content: 'nick:some_yubikey'
  ) }

  it { is_expected.to_not create_directory('/home/test1/.config/Yubico') }
  it { is_expected.to_not create_file('/home/test1/.config/Yubico/u2f_keys') }
end
