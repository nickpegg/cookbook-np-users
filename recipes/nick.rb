require 'yaml'

home_dir = '/home/nick'

package 'zsh'

user_account 'nick' do
  home home_dir
  groups ['sudo', 'docker']
  shell '/usr/bin/zsh'
  ssh_keygen false
  ssh_keys [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC5ec/R2Tgmk3/Ta/bzO/sH426BRq4YZuqv0dNW5FdA81lgZo6gr3X8b9EfMacpsig1p6SRl1bLVkD4IEXIOKmKjC9g2jVxHLipSvR3Xcg93WsuPbSymbDyngxOz0tDyKQsk7yhLjqcpuk4DHmFRk5L/aZq1uHaSc/upJSDFsLYOZ2WqOqwquaRyFpJBuTgdiNLPwXXrSi87MoEDxXu0mQ76Q3+Y/xp9gJzs3bhjgtcZZQI6HsqgVbOQsOHMQyY63HQDGfq1HfB3nGpRPC3BdYVUWdNgIGVxONbHhdVBHAsXr0ISVnMhBCsqufqopYbZxg5/qBnbapDLsgVs9f19KxP/WeiWZG5dVnlyf5pdGOqZ7nbU11MyXNVycq34kbCSHnwn2skxXAd4SCUJ1HgFp1IsAFBIj2J0lPVbB6z6HjVIdBn88h9/pZDR1RoX/uA3pLVwNc7bWmx44+TWEHvlMsgL5R986Pr/5xZlHiUueKLr70ehO3PAMGFJ5d5JhZi7v2M8XMxgM0c8J3StyXTuXbVCe5S7DEh01DeOpEhs82bfm9/DEwBpNtu52PUTvO1mx/iZavJSVHIH/OoMAw53P5Ujq70ytxfm2Z9GaCcSURoOhwB8+Qiisg0yUYEt+YkgYhnu2Xqro1R/ZHg//rS9gQy1E1Hu6z/lGLLFeL2liw8ww== nick@polo",
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCXBEv9I5JTjFLOaKT3wABKODcEJb3NBn42uEDT0a2woyph0h14IW7t4hb359Q04/OeMYEHdK7uZUICB5B5A2LXgRwxw5ZZbdpUMxJD++QosrLAATk5V27PuYMJWKcqUlVtI/6KHiOqTWXX3cjuTFZlV4HHEGJEEowt6zSOBchTFHwjismuVEoVNwMD4XRHklwNKWg77NT3pQLlN+idLtAdzRwSocdve89Widnsn7K67hjglLWX6sV4YMzht5FrrOxX523QKs/Mwtiydsgg5C5D+uXPVsCW/cuK/N5l2KCpqsHc0KQls2V8f/DwuKYoOJ5k8c6oNdQXVge56i213Zmd phone password store",
  ]
end

package 'git'

git ::File.join(home_dir, '.oh-my-zsh') do
  repository  'https://github.com/robbyrussell/oh-my-zsh.git'
  user        'nick'
end

# Set up dotfiles
# TODO: Make this a resource?
package 'cpio'

unless node['np-users']['dotfiles']['repos']['nick'].nil?
  repos = node['np-users']['dotfiles']['repos']['nick'].to_a
else
  repos = []
end

ddd_cfg = { 'dots' => repos }

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
end

execute '... install' do
  user        'nick'
  group       'nick'
  cwd         home_dir
  environment('HOME' => home_dir)
  command     '.../... install'

  only_if ".../... super_update 2>&1 | grep -E '(^Cloning into|^Fast-forward)'"
end
