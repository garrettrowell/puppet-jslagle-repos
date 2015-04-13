class repos::yum::asterisk {

  case $::osfamily {

    RedHat: {

      if !defined(Package['dnsmasq']) { package { 'dnsmasq': } }

      package { 'asterisknow-version':
        require  => Package['dnsmasq'],
        provider => rpm,
        source   => "http://packages.asterisk.org/centos/6/current/${::architecture}/RPMS/asterisknow-version-3.0.0-1_centos6.noarch.rpm",
        ensure   => installed,
      }

      # Enable the asterisk-11 repo
      yumrepo { 'asterisk-11':
        require => Package['asterisknow-version'],
        enabled => 1,
      }

    }

    default: { err("OSFamily ${::osfamily} not supported")}

  }

}

