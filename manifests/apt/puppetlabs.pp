# == Class: repos::apt::puppetlabs
#

class repos::apt::puppetlabs (
  $enabledevel    = false,
  $enableproducts = true,
  $enabledeps     = true
) {

  include ::apt

  if ($enableproducts) {
    $prepo = 'main'
  } else {
    $prepo = ''
  }

  if ($enabledeps) {
    $dprepo = 'dependencies'
  } else {
    $dprepo = ''
  }

  if ($enabledevel) {
    $drepo = 'devel'
  } else {
    $drepo = ''
  }

  $repos = "${prepo} ${dprepo} ${drepo}"

  if ($repos != '  ') {
    $ensure = present
  } else {
    $ensure = absent
  }

  apt::source { 'puppetlabs':
    ensure     => $ensure,
    location   => 'http://apt.puppetlabs.com',
    repos      => strip($repos),
    key        => '4BD6EC30',
    key_server => 'pgp.mit.edu',
  }

}
