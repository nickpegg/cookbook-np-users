require 'yaml'

home_dir = '/home/nick'

package 'dotfiles requirements' do
  package_name %w(git vim zsh)
end

nick_ssh_keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC5ec/R2Tgmk3/Ta/bzO/sH426BRq4YZuqv0dNW5FdA81lgZo6gr3X8b9EfMacpsig1p6SRl1bLVkD4IEXIOKmKjC9g2jVxHLipSvR3Xcg93WsuPbSymbDyngxOz0tDyKQsk7yhLjqcpuk4DHmFRk5L/aZq1uHaSc/upJSDFsLYOZ2WqOqwquaRyFpJBuTgdiNLPwXXrSi87MoEDxXu0mQ76Q3+Y/xp9gJzs3bhjgtcZZQI6HsqgVbOQsOHMQyY63HQDGfq1HfB3nGpRPC3BdYVUWdNgIGVxONbHhdVBHAsXr0ISVnMhBCsqufqopYbZxg5/qBnbapDLsgVs9f19KxP/WeiWZG5dVnlyf5pdGOqZ7nbU11MyXNVycq34kbCSHnwn2skxXAd4SCUJ1HgFp1IsAFBIj2J0lPVbB6z6HjVIdBn88h9/pZDR1RoX/uA3pLVwNc7bWmx44+TWEHvlMsgL5R986Pr/5xZlHiUueKLr70ehO3PAMGFJ5d5JhZi7v2M8XMxgM0c8J3StyXTuXbVCe5S7DEh01DeOpEhs82bfm9/DEwBpNtu52PUTvO1mx/iZavJSVHIH/OoMAw53P5Ujq70ytxfm2Z9GaCcSURoOhwB8+Qiisg0yUYEt+YkgYhnu2Xqro1R/ZHg//rS9gQy1E1Hu6z/lGLLFeL2liw8ww== nick@polo",
]


# HACK: Add some more SSH keys to golf, mostly to pull git repos
if node['hostname'] == 'golf'
  nick_ssh_keys += [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCXBEv9I5JTjFLOaKT3wABKODcEJb3NBn42uEDT0a2woyph0h14IW7t4hb359Q04/OeMYEHdK7uZUICB5B5A2LXgRwxw5ZZbdpUMxJD++QosrLAATk5V27PuYMJWKcqUlVtI/6KHiOqTWXX3cjuTFZlV4HHEGJEEowt6zSOBchTFHwjismuVEoVNwMD4XRHklwNKWg77NT3pQLlN+idLtAdzRwSocdve89Widnsn7K67hjglLWX6sV4YMzht5FrrOxX523QKs/Mwtiydsgg5C5D+uXPVsCW/cuK/N5l2KCpqsHc0KQls2V8f/DwuKYoOJ5k8c6oNdQXVge56i213Zmd phone password store",
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCw81jIuRFlRmoooG7ofCdibnCswbKcjQepP0CNGJuZsjxN9RFNJtzeP5Kt+Zcyr6E5E+ssSbWGgboTst45B1HnrHnjJiMp7gBzvvsvveCTtyqhmVSpophUlkY7FU7MAdGa1W5cJhFQo5vaakFqnvXelYXUuQwyLPHKEQkDNUamWDd96cEHMSGdh2WZMsXZgNoigMwWE4FXWioqidHf5BNwghRo0E20bO/Wa6qCpU/35HhsTZrhwmYOPJ8/0Rs2jUN+rfpKYkQ14LBKMlX4zYqYYopzOyHPLeLwUADZ2tGFO21B5JdCiAgBJ5D6w/gOmiqOuY+eeLzQLClzVetIR7csbnqMHE3tvK1YJj+e1XhGSLcAAgcA0VkTCX8MZ4JAd70mPHRww33oClZylClR7G8T1/kaDwmYRU+rdfGy18LN8neWZor1yMRmUXhBheffqEJ3UvrTIyGiGBkYEvh/De477z2fJTW6jXiMr6Hc+qENReXpFpCO/uXEF7W+0igSboElSi6iHvMxfcT7LcnDKzbNs86Oixm/hHLVHCxxMkU2R3nuAaiOSxdOG0YP6sxSI6C45+oP5P+ISViKSj5RtCAltmQpzAoENin4nepXDgyLnX1Uq4u4dW9A48yiEklnRFG/+mykUlyxp0gIQvF5dTfC3DYXdLtpKtIi0eQo0aEJOw== npegg@npegg-mbp.corp.dropbox.com",
  ]
end

user_account 'nick' do
  home home_dir
  groups ['sudo', 'docker']
  shell '/usr/bin/zsh'
  ssh_keygen false
  ssh_keys nick_ssh_keys
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
