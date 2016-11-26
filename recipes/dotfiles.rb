#
# Cookbook Name:: np-users
# Recipe:: dotfiles
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'yaml'

include_recipe 'user::data_bag'

package 'cpio'
package 'git'

data_bag('users').each do |user|
  dbag = Chef::EncryptedDataBagItem.load('users', user)
  next unless dbag['dotfiles_repos']

  home = ::File.join(node['user']['home_root'], user)

  ddd_cfg = {
    'dots' => dbag['dotfiles_repos'].to_a
  }

  git ::File.join(home, '...') do
    action :checkout
    repository 'https://github.com/ingydotnet/...'
    user user
    enable_checkout false
  end

  file ::File.join(home, '...', 'conf') do
    user user
    group user
    mode '0644'

    content ddd_cfg.to_yaml
  end

  execute "... install" do
    #action :nothing
    user        user
    group       user
    cwd         home
    environment('HOME' => home)
    command     '.../... install'

    only_if ".../... super_update 2>&1 | grep -E '(^Cloning into|^Fast-forward)'"
  end
end
