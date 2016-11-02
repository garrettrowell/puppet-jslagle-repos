# == Class: repos::yum::epel
#

class repos::yum::epel(
  $enablebase = true,
  $enabletesting = true,
  $baseurl = 'http://download.fedoraproject.org/pub/epel',
  $cobbler = false,
) {
  include ::stdlib

  $rcobbler = str2bool($cobbler)
  validate_string($baseurl)

  case $::os['hardware'] {
    'amd64','x86_64': {
      $basearch='x86_64'
    }
    'i386','i486','i586','i686': {
      $basearch='i386'
    }
    default: {
      err("Architecture ${::os['hardware']} not supported")
    }
  }

  if ($rcobbler) {
    $realbu = "${baseurl}/EPEL-${::os['release']['major']}-${basearch}"
    $realtu = "${baseurl}/EPEL-testing-${::os['release']['major']}-${basearch}"
  } else {
    $realbu = "${baseurl}/${::os['release']['major']}/${basearch}"
    $realtu = "${baseurl}/testing/${::os['release']['major']}/${basearch}"
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

  case $::os['family'] {
    'RedHat': {
      yumrepo { 'epel':
        baseurl  => $realbu,
        enabled  => $eb,
        gpgcheck => '1',
        gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${::os['release']['major']}",
        descr    => "Extra Packages for Enterprise Linux ${::os['release']['major']} - ${basearch}",
      }
      yumrepo { 'epel-testing':
        baseurl  => $realtu,
        enabled  => $et,
        gpgcheck => '1',
        gpgkey   => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${::os['release']['major']}",
        descr    => "Extra Packages for Enterprise Linux ${::os['release']['major']} - Testing - ${basearch}",
      }
      file { "/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${::os['release']['major']}":
        ensure => present,
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        source => "puppet:///modules/repos/yum/RPM-GPG-KEY-EPEL-${::os['release']['major']}",
      }

      repos::yum::rpm_gpg_key { "/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-${::os['release']['major']}": }
    }
    default: {
      err("OS Family ${::os['family']} not supported")
    }
  }

}
