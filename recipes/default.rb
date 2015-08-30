#
# Cookbook Name:: np-users
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'np-users::nick'
include_recipe 'user::data_bag'
