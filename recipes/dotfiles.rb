#
# Cookbook Name:: np-users
# Recipe:: dotfiles
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require 'yaml'

include_recipe 'user::data_bag'

package %w(cpio git)

data_bag('users').each do |user|
  dbag = Chef::EncryptedDataBagItem.load('users', user)
  next unless dbag['dotfiles_repos']

  home = ::File.join(node['user']['home_root'], user)

  repos = dbag['dotfiles_repos'].to_a

  # Merge in any repos that are specified via attributes
  unless node[:np_users][:dotfiles][:repos][user].nil?
    repos = node[:np_users][:dotfiles][:repos][user].to_a + repos
  end

  # Ensure all repos have a path. Use the branch name if not given.
  repos.each do |repo|
    repo['path'] ||= repo['branch'] unless repo['branch'].nil?
  end

  ddd_cfg = { 'dots' => repos }

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

  execute '... install' do
    user        user
    group       user
    cwd         home
    environment('HOME' => home)
    command     '.../... install'

    only_if ".../... super_update 2>&1 | grep -E '(^Cloning into|^Fast-forward)'"
  end
end
