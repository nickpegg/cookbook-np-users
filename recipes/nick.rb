include_recipe 'user::data_bag'

home = '/home/nick'

package 'zsh'
package 'git'

git ::File.join(home, '.oh-my-zsh') do
  repository  'https://github.com/robbyrussell/oh-my-zsh.git'
  user        'nick'
end

if node[:np_users][:nick][:irc]
  package 'irssi'

  directory ::File.join(home, '.irssi') do
    owner 'nick'
    group 'nick'
    mode '0750'
  end

  cookbook_file ::File.join(home, '.irssi/config') do
    source 'nick/irssi_config'
    owner 'nick'
    group 'nick'
    mode '0640'
  end
end
