# Manages a system user with a stable UID, for users which should exist across
# the fleet

resource_name :np_system_user
provides :np_system_user

default_action :create

property :username, String, name_property: true
property :group, String
property :comment, String
property :home, String, default: '/dev/null'
property :shell, String, default: '/bin/false'

action :create do
  unless node['np-users']['uids'].has_key? new_resource.username
    raise "No UID defined in attributes for user #{new_resource.username}"
  end

  if new_resource.group.nil?
    group_name = new_resource.username
  else
    group_name = new_resource.group
  end

  group group_name do
    gid node['np-users']['uids'][new_resource.username]
  end

  user new_resource.username do
    system true
    manage_home false
    uid node['np-users']['uids'][new_resource.username]
    gid group_name

    comment new_resource.comment
    home new_resource.home
    shell new_resource.shell
  end
end

action :remove do
  user new_resource.username do
    action :remove
  end
end
