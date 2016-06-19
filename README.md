[![Build Status](https://travis-ci.org/nickpegg/cookbook-np-users.svg?branch=master)](https://travis-ci.org/nickpegg/cookbook-np-users)

# np-users
Sets up users on one of my machines, including SSH keys, U2F keys, and dotfile
repos. The `nick` user has a few extra things, so there's a separate recipe for those.

## Personal Cookbook Notice
This is a personal cookbook and I haven't really taken the care to generalize
it. It's public in hopes that maybe it's of use to someone, either directly
with its content or seeing how I do things with Chef.

## Testing
It's assumed that you have chefdk installed.

```bash
chef exec rake
chef exec kitchen test
```
