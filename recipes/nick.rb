package 'zsh'

user_account 'nick'

# TODO: set up oh-my-zsh
# TODO: set up dotfiles
# TODO: set up rbenv

if node[:np_users][:nick][:irc]
  package 'irssi'

  directory '/home/nick/.irssi/' do
    owner 'nick'
    group 'nick'
    mode  '0750'
  end

  cookbook_file '/home/nick/.irssi/config' do
    source  'nick/irssi_config'
    owner   'nick'
    group   'nick'
    mode    '0640'
  end
end
