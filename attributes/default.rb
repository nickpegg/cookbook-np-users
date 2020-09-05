default[:user][:ssh_keygen] = false

# Extra SSH keys can be specified as node attributes
default['np-users']['extra_ssh_keys'] = {
  'nick' => [],
}

default['np-users']['nick']['in_docker_group'] = false

# Hash of user IDs which should be global across the fleet, such as for NFS.
# You should always opt to put users here rather than in individual cookbooks
# so that this is the single, canonical list of UIDs.
default['np-users']['uids'] = {
  'consul'      => 2000,
  'nomad'       => 2001,
  'prometheus'  => 2002,
}
