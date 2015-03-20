class repos::asterisk {
  case $::osfamily {
    'RedHat': {
      include repos::yum::asterisk
    }
    default: {
      notice("OSFamily ${::osfamily} not support for puppet repo")
    }
  }
}

