#
# Cookbook Name:: np-users
# Recipe:: yubikey
#
# Sets up yubikey key files for users for use with pam_u2f

include_recipe 'user::data_bag'

data_bag('users').each do |user|
  dbag = Chef::EncryptedDataBagItem.load('users', user)
  next if dbag['u2f_keys'].nil?

  homedir = ::File.join('/home', user)
  yubi_conf_path = ::File.join(homedir, '.config', 'Yubico')

  directory ::File.join(homedir, '.config') do
    owner user
    group user
  end

  directory yubi_conf_path do
    owner     user
    group     user
  end

  file ::File.join(yubi_conf_path, 'u2f_keys') do
    owner   user
    group   user
    content dbag['u2f_keys'].map { |key| [user, key].join(':') }.join("\n")
  end
end
