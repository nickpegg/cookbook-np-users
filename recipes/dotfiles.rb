#
# Cookbook Name:: np-users
# Recipe:: dotfiles
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'user::data_bag'

include_recipe 'python'
python_pip 'dotfiles'

package 'git'

data_bag('users').each do |user|
  dbag = Chef::EncryptedDataBagItem.load('users', user)
  next unless dbag['dotfiles_repo']

  home = ::File.join(node['user']['home_root'], user)

  git ::File.join(home, '.dotfiles') do
    repository  dbag['dotfiles_repo']
    user        user
    group       user
    reference   node[:np_users][:dotfiles][:git_ref]

    notifies :run, "execute[sync #{user} dotfiles]", :delayed
  end

  config_path = ::File.join(home, '.dotfiles', 'dotfilesrc')

  execute "sync #{user} dotfiles" do
    action      :nothing
    user        user
    group       user
    cwd         home
    environment('HOME' => home)
    command "dotfiles --sync -C #{config_path}"
  end
end
