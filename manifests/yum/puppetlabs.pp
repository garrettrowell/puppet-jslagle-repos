class repos::yum::puppetlabs(
  $enableproducts = true,
  $enabledeps = true,
  $enabledevel = false,
  $baseurl = 'http://yum.puppetlabs.com',
  $producturl = '',
  $depsurl = '',
  $develurl = ''
) {
  case $::osfamily {
    RedHat: {
      $verarray = split($::operatingsystemrelease,'[.]')
      $majver = $verarray[0]
      case $::architecture {
        'amd64','x86_64': {
          $arch = 'x86_64'
        }
        'i386','i686': {
          $arch = 'i386'
        }
        default: {
          err("Architecture ${::architecture} not supported")
        }
      }

      if ($producturl != '') {
        $realpurl = $producturl
      } else {
        $producttag = "/el/${majver}/products/${arch}"
        $realpurl = "${baseurl}${producttag}"
      }

      if ($depsurl != '') {
        $realdpurl = $depsurl
      } else {
        $depstag = "/el/${majver}/dependencies/${arch}"
        $realdpurl = "${baseurl}${depstag}"
      }

      if ($develurl != '') {
        $realdurl = $develurl
      } else {
        $develtag = "/el/${majver}/devel/${arch}"
        $realdurl = "${baseurl}${develtag}"
      }

      if ($enableproducts) {
        $realpe = 1
      } else {
        $realpe = 0
      }


      if ($enabledeps) {
        $realdpe = 1
      } else {
        $realdpe = 0
      }

      if ($enabledevel) {
        $realde = 1
      } else {
        $realde = 0
      }

      yumrepo { 'puppetlabs-products':
        baseurl  => $realpurl,
        enabled  => $realpe,
        gpgcheck => 1,
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
        descr    => "Puppet Labs Products El ${majver} - ${arch}"
      }

      yumrepo { 'puppetlabs-deps':
        baseurl  => $realdpurl,
        enabled  => $realdpe,
        gpgcheck => 1,
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
        descr    => "Puppet Labs Dependencies El ${majver} - ${arch}"
      }

      yumrepo { 'puppetlabs-devel':
        baseurl  => $realdurl,
        enabled  => $realde,
        gpgcheck => 1,
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
        descr    => "Puppet Labs Devel El ${majver} - ${arch}"
      }

      file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs':
        ensure => present,
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        source => 'puppet:///modules/repos/yum/RPM-GPG-KEY-puppetlabs',
      }

      repos::yum::rpm_gpg_key { '/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs': }

    }
    default: { err("OS Family ${::osfamily} not supported")}
  }


}
