default[:user][:ssh_keygen] = false

# Extra SSH keys can be specified as node attributes
default['np-users']['extra_ssh_keys'] = {
  'nick' => [],
}

default['np-users']['nick']['in_docker_group'] = false
