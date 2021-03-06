name 'np-users'
maintainer 'Nick Pegg'
maintainer_email 'nick@nickpegg.com'
license 'MIT'
description 'Sets up users'
long_description 'Sets up users'
version '0.2.0'

source_url 'https://github.com/nickpegg/cookbook-np-users'
issues_url 'https://github.com/nickpegg/cookbook-np-users/issues'

depends 'apt'
depends 'user', '>= 0.6.0'

supports 'arch'
supports 'debian', '~> 10.0'
supports 'ubuntu', '= 18.04'
supports 'ubuntu', '= 20.04'
