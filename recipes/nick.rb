home = '/home/nick'

package 'zsh'
package 'git'

git ::File.join(home, '.oh-my-zsh') do
  repository  'https://github.com/robbyrussell/oh-my-zsh.git'
  user        'nick'
end

# TODO: set up dotfiles
include_recipe 'python'
python_pip 'dotfiles'

cookbook_file ::File.join(home, '.dotfilesrc') do
  source  'nick/dotfilesrc'
  user    'nick'
  group   'nick'
end

git ::File.join(home, '.dotfiles') do
  repository  'https://github.com/nickpegg/dotfiles'
  user        'nick'
  group       'nick'

  notifies :create, "file[#{home}/.dotfilesrc]"
  notifies :run, "execute[sync nick dotfiles]", :delayed
end

file ::File.join(home, '.dotfilesrc') do
  user    'nick'
  group   'nick'
  content "file:///#{home}/."
  action  :nothing

  notifies :run, "execute[sync nick dotfiles]", :delayed
end

execute 'sync nick dotfiles' do
  action      :nothing
  user        'nick'
  group       'nick'
  cwd         home
  environment ({'HOME' => home})
  command     'dotfiles --sync'
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
