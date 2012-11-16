class repos::puppetlabs {
  case $::osfamily {
    'RedHat': {
      include repos::yum::puppetlabs
    }
    'Debian': {
      include repos::apt::puppetlabs
    }
    default: {
      notice("OSFamily ${::osfamily} not support for puppet repo")
    }
}
