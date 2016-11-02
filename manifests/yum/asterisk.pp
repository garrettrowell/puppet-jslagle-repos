# == Class: repos::yum::asterisk
#

class repos::yum::asterisk {

  case $::os['family'] {

    'RedHat': {

      if !defined(Package['dnsmasq']) { package { 'dnsmasq': } }

      package { 'asterisknow-version':
        ensure   => installed,
        require  => Package['dnsmasq'],
        provider => rpm,
        source   => "http://packages.asterisk.org/centos/6/current/${::os['hardware']}/RPMS/asterisknow-version-3.0.0-1_centos6.noarch.rpm",
      }

      # Enable the asterisk-11 repo
      yumrepo { 'asterisk-11':
        require => Package['asterisknow-version'],
        enabled => 1,
      }

    }

    default: { err("OSFamily ${::os['family']} not supported")}

  }

}

