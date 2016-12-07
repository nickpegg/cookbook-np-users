# List of repos for different users which is prepended to what's set in their
# data bags. This is meant to provide a way to override which repos are
# checked out on a host-by-host basis for each user. For example, on a
# workstation machine you may want some additional repos.
#
# Easiest way to describe the format is to give an example:
# node.default[:dotfiles][:repos][user] = [
#   {
#     repo: 'https://github.com/user/dotfiles',
#     branch: 'some-branch',
#     path: 'some-dotdotdot-path'
#   },
# ]
#
# If `:path` is omitted, the branch name is used for it
default['np-users']['dotfiles']['repos'] = {}
