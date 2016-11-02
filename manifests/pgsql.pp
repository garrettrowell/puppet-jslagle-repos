# == Class: repos::pgsql
#

class repos::pgsql {
  case $::os['family'] {
    'RedHat': {
      include ::repos::yum::pgsql
    }
    default: {
      notice("OSFamily ${::os['family']} not support for puppet repo")
    }
  }
}
