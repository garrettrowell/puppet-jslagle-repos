class repos::yum::epel(
  $enablebase = true,
  $enabletesting = true,
  $baseurl = 'http://download.fedoraproject.org/pub/epel',
  $cobbler = false,
) {
  include stdlib

  $rcobbler = str2bool($cobbler)
  validate_string($baseurl)

  case $::architecture {
    'amd64','x86_64': {
      $basearch='x86_64'
    }
    'i386','i486','i586','i686': {
      $basearch='i386'
    }
    default: {
      err("Architecture ${::architecture} not supported")
    }
  }

  $verarray = split($::operatingsystemrelease,'[.]')
  $majver = $verarray[0]


  if ($rcobbler) {
    $realbu = "${baseurl}/EPEL-${majver}-${basearch}"
    $realtu = "${baseurl}/EPEL-testing-${majver}-${basearch}"
  } else {
    $realbu = "${baseurl}/${majver}/${basearch}"
    $realtu = "${baseurl}/testing/${majver}/${basearch}"
  }

  if ($enablebase) {
    $eb = 1
  } else {
    $eb = 0
  }

  if ($enabletesting) {
    $et = 1
  } else {
    $et = 0
  }

  case $::osfamily {
    RedHat: {
      yumrepo { 'epel':
        baseurl  => $realbu,
        enabled  => $eb,
        gpgcheck => '1',
        gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${majver}",
        descr    => "Extra Packages for Enterprise Linux ${majver} - ${basearch}",
      }
      yumrepo { 'epel-testing':
        baseurl  => $realtu,
        enabled  => $et,
        gpgcheck => '1',
        gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${majver}",
        descr    => "Extra Packages for Enterprise Linux ${majver} - Testing - ${basearch}",
      }
      file { "/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${majver}":
        ensure => present,
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        source => "puppet:///modules/repos/yum/RPM-GPG-KEY-EPEL-${majver}",
      }

      repos::yum::rpm_gpg_key { "/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${majver}": }
    }
    default: {
      err("OS Family ${::osfamily} not supported")
    }



  }


}
