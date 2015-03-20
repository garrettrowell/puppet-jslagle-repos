class repos::yum::asterisk (

  $version       = '11',
  $baseurl       = 'http://packages.asterisk.org/',

) {

  case $::osfamily {

    RedHat: {

      $majver    = $::operatingsystemmajrelease
      $repoDef   = "asterisk-${version}"

      # Asterisk Source Repo's
      yumrepo { "asterisk-${version}":
        name     => $repoDef,
        baseurl  => "${baseurl}centos/${majver}/${repoDef}/${::hardwareisa}/",
        enabled  => true,
        gpgcheck => false,
        descr    => "CentOS-${majver} - Asterisk - ${version}",
      }

      # Dependencies
      yumrepo { 'asterisk-current':
        name     => 'asterisk-current',
        baseurl  => "${baseurl}centos/${majver}/current/${::hardwareisa}/",
        enabled  => true,
        gpgcheck => false,
        descr    => "CentOS-${majver} - Asterisk - Current",
      }

      # Dependencies
      yumrepo { 'digium-current':
        name     => 'digium-current',
        baseurl  => "http://packages.digium.com/centos/$majver/current/${::hardwareisa}/",
        enabled  => true,
        gpgcheck => false,
        descr    => "CentOS-${majver} - Digium - Current",
      }

    }

    default: { err("OSFamily ${::osfamily} not supported")}

  }

}

