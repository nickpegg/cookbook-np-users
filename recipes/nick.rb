require 'yaml'

home_dir = '/home/nick'

package 'git'
package 'vim'
package 'zsh'

nick_ssh_keys = [
  "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC5ec/R2Tgmk3/Ta/bzO/sH426BRq4YZuqv0dNW5FdA81lgZo6gr3X8b9EfMacpsig1p6SRl1bLVkD4IEXIOKmKjC9g2jVxHLipSvR3Xcg93WsuPbSymbDyngxOz0tDyKQsk7yhLjqcpuk4DHmFRk5L/aZq1uHaSc/upJSDFsLYOZ2WqOqwquaRyFpJBuTgdiNLPwXXrSi87MoEDxXu0mQ76Q3+Y/xp9gJzs3bhjgtcZZQI6HsqgVbOQsOHMQyY63HQDGfq1HfB3nGpRPC3BdYVUWdNgIGVxONbHhdVBHAsXr0ISVnMhBCsqufqopYbZxg5/qBnbapDLsgVs9f19KxP/WeiWZG5dVnlyf5pdGOqZ7nbU11MyXNVycq34kbCSHnwn2skxXAd4SCUJ1HgFp1IsAFBIj2J0lPVbB6z6HjVIdBn88h9/pZDR1RoX/uA3pLVwNc7bWmx44+TWEHvlMsgL5R986Pr/5xZlHiUueKLr70ehO3PAMGFJ5d5JhZi7v2M8XMxgM0c8J3StyXTuXbVCe5S7DEh01DeOpEhs82bfm9/DEwBpNtu52PUTvO1mx/iZavJSVHIH/OoMAw53P5Ujq70ytxfm2Z9GaCcSURoOhwB8+Qiisg0yUYEt+YkgYhnu2Xqro1R/ZHg//rS9gQy1E1Hu6z/lGLLFeL2liw8ww== nick@polo",
]

nick_ssh_keys += node['np-users']['extra_ssh_keys']['nick']

groups = ['sudo']
if node['np-users']['nick']['in_docker_group']
  groups << 'docker'
end

user_account 'nick' do
  home home_dir
  groups groups
  shell '/usr/bin/zsh'
  ssh_keygen false
  ssh_keys nick_ssh_keys
end


# Set up dotfiles
# TODO: Make this a resource?
unless node['np-users']['dotfiles']['repos']['nick'].nil?
  package 'cpio'
  ddd_cfg = { 'dots' => node['np-users']['dotfiles']['repos']['nick'].to_a }

  git ::File.join(home_dir, '...') do
    action :checkout
    repository 'https://github.com/ingydotnet/...'
    user 'nick'
    enable_checkout false
  end

  file ::File.join(home_dir, '...', 'conf') do
    user 'nick'
    group 'nick'
    mode '0644'

    content ddd_cfg.to_yaml
    notifies :run, 'execute[... install]', :immediately
  end

  execute '... install' do
    action      :nothing
    user        'nick'
    group       'nick'
    cwd         home_dir
    environment('HOME' => home_dir)
    command     "#{home_dir}/.../bin/... upgrade"
    timeout     30
  end

  execute 'bootstrap vim' do
    action      :nothing
    user        'nick'
    group       'nick'
    cwd         home_dir
    environment('HOME' => home_dir)
    command     "vim -u #{home_dir}/.vimrc.bundles +PluginInstall +qall"
    timeout     60

    only_if     "ls #{home_dir}/.vimrc.bundles"
    subscribes :run, 'execute[... install]', :immediately
  end
end
