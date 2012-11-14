class repos::yum::puppetlabs(
  $enableproducts = true,
  $enabledeps = true,
  $enabledevel = false,
  $baseurl = "http://yum.puppetlabs.com",
  $producturl = "",
  $depsurl = "",
  $develurl = ""
) {
  case $::osfamily {
    RedHat: {
      $verarray = split($::operatingsystemrelease,'[.]')
      $majver = $verarray[0]

      if ($producturl != "") {
        $realpurl = $producturl
      } else {
        $producttag = "/el/${majver}/products/${::hardwareisa}"
        $realpurl = "${baseurl}${producttag}"
      }

      if ($depsurl != "") {
        $realdpurl = $depsurl
      } else {
        $depstag = "/el/${majver}/dependencies/${::hardwareisa}"
        $realdpurl = "${baseurl}${depstag}"
      }

      if ($develurl != "") {
        $realdurl = $develurl
      } else {
        $develtag = "/el/${majver}/devel/${::hardwareisa}"
        $realdurl = "${baseurl}${develtag}"
      }

      if ($enableproducts) {
        yumrepo { "puppetlabs-products":
          baseurl => $realpurl,
          enabled => 1,
          gpgcheck => 1,
          gpgkey => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs",
          descr => "Puppet Labs Products El ${majver} - ${::hardwareisa}"
        }
      }

      if ($enabledeps) {
        yumrepo { "puppetlabs-deps":
          baseurl => $realdpurl,
          enabled => 1,
          gpgcheck => 1,
          gpgkey => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs",
          descr => "Puppet Labs Dependencies El ${majver} - ${::hardwareisa}"
        }
      }

      if ($enabledevel) {
        yumrepo { "puppetlabs-products":
          baseurl => $realdurl,
          enabled => 1,
          gpgcheck => 1,
          gpgkey => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs",
          descr => "Puppet Labs Devel El ${version} ${majver} - ${::hardwareisa}"
        }
      }

      file { "/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs":
        ensure => present,
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        source => "puppet:///modules/pageplus/yum/RPM-GPG-KEY-puppetlabs",
      }

      repos::yum::rpm_gpg_key { "/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs": }

    }
    default: { err("OS Family ${::osfamily} not supported")}
  }


}
