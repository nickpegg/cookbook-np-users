require 'yaml'

home_dir = '/home/nick'

apt_update do
  only_if { node.platform?('debian') || node.platform?('ubuntu') }
end

package %w(git sudo vim zsh)

# python > 3.5 is required by dotbot
if platform?('arch')
  package 'python'
else
  package 'python3'
end

nick_ssh_keys = [
  'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAcVz27V8ysX1OYv5f89qHK7FktiHVruU4dJRsJvoDQn nick@passat',
  'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC5ec/R2Tgmk3/Ta/bzO/sH426BRq4YZuqv0dNW5FdA81lgZo6gr3X8b9EfMacpsig1p6SRl1bLVkD4IEXIOKmKjC9g2jVxHLipSvR3Xcg93WsuPbSymbDyngxOz0tDyKQsk7yhLjqcpuk4DHmFRk5L/aZq1uHaSc/upJSDFsLYOZ2WqOqwquaRyFpJBuTgdiNLPwXXrSi87MoEDxXu0mQ76Q3+Y/xp9gJzs3bhjgtcZZQI6HsqgVbOQsOHMQyY63HQDGfq1HfB3nGpRPC3BdYVUWdNgIGVxONbHhdVBHAsXr0ISVnMhBCsqufqopYbZxg5/qBnbapDLsgVs9f19KxP/WeiWZG5dVnlyf5pdGOqZ7nbU11MyXNVycq34kbCSHnwn2skxXAd4SCUJ1HgFp1IsAFBIj2J0lPVbB6z6HjVIdBn88h9/pZDR1RoX/uA3pLVwNc7bWmx44+TWEHvlMsgL5R986Pr/5xZlHiUueKLr70ehO3PAMGFJ5d5JhZi7v2M8XMxgM0c8J3StyXTuXbVCe5S7DEh01DeOpEhs82bfm9/DEwBpNtu52PUTvO1mx/iZavJSVHIH/OoMAw53P5Ujq70ytxfm2Z9GaCcSURoOhwB8+Qiisg0yUYEt+YkgYhnu2Xqro1R/ZHg//rS9gQy1E1Hu6z/lGLLFeL2liw8ww== nick@polo',
  'ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFD7pQ4LN7bd3gBgJL34EwxkcL0x7/SE9GD/qOofAcSe pixel4a JuiceSSH',
]

nick_ssh_keys += node['np-users']['extra_ssh_keys']['nick']

groups = ['sudo']
if node['np-users']['nick']['in_docker_group']
  groups << 'docker'
end

user 'nick' do
  home home_dir
  shell '/usr/bin/zsh'
end

directory home_dir do
  owner 'nick'
  group 'nick'
end

groups.each do |group_name|
  group group_name do
    append true
    members 'nick'
  end
end

directory ::File.join(home_dir, '.ssh') do
  owner 'nick'
  group 'nick'
end

file ::File.join(home_dir, '.ssh/authorized_keys') do
  owner 'nick'
  group 'nick'
  content nick_ssh_keys.join("\n")
end

# Set up dotfiles
dotfile_attrs = node['np-users']['dotfiles']['repos']['nick']
unless dotfile_attrs.nil?
  dotfiles_path = dotfile_attrs['path'] || ::File.join(home_dir, '.dotfiles')
  dotfiles_ref = dotfile_attrs['ref'] || 'main'

  git dotfiles_path do
    action :checkout
    repository dotfile_attrs['repo']
    revision dotfiles_ref
    user 'nick'
    enable_submodules true
    # enable_checkout false

    notifies :run, 'execute[dotbot install]', :immediately
  end

  execute 'dotbot install' do
    action      :nothing
    user        'nick'
    group       'nick'
    cwd         dotfiles_path
    environment('HOME' => home_dir)
    command     'bin/dotbot -c install.conf.yaml'
    timeout     30
  end

  execute 'bootstrap vim' do
    action      :nothing
    user        'nick'
    group       'nick'
    cwd         home_dir
    environment('HOME' => home_dir)
    command     "vim -u #{home_dir}/.vimrc.plugins +PlugInstall +qall"
    timeout     300

    only_if     "ls #{home_dir}/.vimrc.plugins"
    subscribes :run, 'execute[dotbot install]', :immediately
  end
end
