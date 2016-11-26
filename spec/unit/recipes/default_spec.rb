#
# Cookbook Name:: np-users
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'np-users::default' do
  before do
    common_stubs

    @chef_run = memoized_runner(described_recipe)
  end

  subject { @chef_run }

  it { is_expected.to include_recipe('user::data_bag') }
  it { is_expected.to include_recipe('np-users::nick') }
end
