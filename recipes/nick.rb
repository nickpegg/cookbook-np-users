include_recipe 'user::data_bag'

home = '/home/nick'

package 'zsh'
package 'git'

git ::File.join(home, '.oh-my-zsh') do
  repository  'https://github.com/robbyrussell/oh-my-zsh.git'
  user        'nick'
end

