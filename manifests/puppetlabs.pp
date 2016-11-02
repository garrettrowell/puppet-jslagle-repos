# == Class: repos::puppetlabs
#

class repos::puppetlabs {
  case $::os['family'] {
    'RedHat': {
      include ::repos::yum::puppetlabs
    }
    'Debian': {
      include ::repos::apt::puppetlabs
    }
    default: {
      notice("OSFamily ${::os['family']} not support for puppet repo")
    }
  }
}
