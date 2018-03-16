name 'np-users'
maintainer 'Nick Pegg'
maintainer_email 'nick@nickpegg.com'
license 'MIT'
description 'Sets up users'
long_description 'Sets up users'
version '0.1.9'

source_url 'https://github.com/nickpegg/cookbook-np-users'
issues_url 'https://github.com/nickpegg/cookbook-np-users/issues'

depends 'apt'
depends 'user', '>= 0.6.0'

supports 'debian', '~> 8.0'
supports 'debian', '~> 9.0'
supports 'ubuntu', '= 14.04'
supports 'ubuntu', '= 16.04'

chef_version '>= 12', '< 14.0'
