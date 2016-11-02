# == Class: repos::epel
#

class repos::epel {
  case $::os['family'] {
    'RedHat': {
      include ::repos::yum::epel
    }
    default: {
      notice("OSFamily ${::os['family']} not support for EPEL")
    }
  }
}

