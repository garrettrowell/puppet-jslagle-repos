# == Class: repos::yum::pgsql
#

class repos::yum::pgsql(
  $version = '9.1',
  $baseurl = 'http://yum.postgresql.org',
  $url = ''
) {

  case $::os['family'] {
    'RedHat': {

      $repotag = "redhat/rhel-${::os['release']['major']}-${::os['hardware']}"

      if ($url != '') {
        $realurl = $url
      } else {
        $realurl = "${baseurl}/${version}/${repotag}/"
      }

      yumrepo { 'pgdg':
        baseurl  => $realurl,
        enabled  => 1,
        gpgcheck => 1,
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG',
        descr    => "PostgreSQL ${version} ${::os['release']['major']} - ${::os['hardware']}",
      }

      file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG':
        ensure => present,
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        source => 'puppet:///modules/repos/yum/RPM-GPG-KEY-PGDG',
      }

      repos::yum::rpm_gpg_key { '/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG': }

    }
    default: { err("OS Family ${::os['family']} not supported")}
  }

}
