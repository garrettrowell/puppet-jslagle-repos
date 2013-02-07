class repos::epel {
  case $::osfamily {
    'RedHat': {
      include repos::yum::epel
    }
    default: {
      notice("OSFamily ${::osfamily} not support for EPEL")
    }
  }
}

