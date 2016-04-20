#
# Cookbook Name:: np-users
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'apt'

include_recipe 'user::data_bag'

include_recipe 'np-users::dotfiles'
include_recipe 'np-users::u2f_keys'

include_recipe 'np-users::nick'
