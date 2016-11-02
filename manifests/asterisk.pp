# == Class: repos::asterisk
#

class repos::asterisk {
  case $::os['family'] {
    'RedHat': {
      include ::repos::yum::asterisk
    }
    default: {
      notice("OSFamily ${::os['family']} not support for puppet repo")
    }
  }
}

