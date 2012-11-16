class repos::pgsql {
  case $::osfamily {
    'RedHat': {
      include repos::yum::pgsql
    }
    default: {
      notice("OSFamily ${::osfamily} not support for puppet repo")
    }
  }
}
