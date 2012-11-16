class repos::apt::puppetlabs (
  $enabledevel = "false",
  $enableproducts = "true",
  $enabledeps = "true"
) {

  include apt

  $renabledevel = str2bool($enabledevel)
  $renableproducts = str2bool($enableproducts)
  $renabledeps = str2bool($enabledeps)

  if ($renableproducts) {
    $prepo = "main"
  } else {
    $prepo = ""
  }
  
  if ($renabledeps) {
    $dprepo = "dependencies"
  } else {
    $dprepo = ""
  }

  if ($renabledevel) {
    $drepo = "devel"
  } else {
    $drepo = ""
  }

  $repos = "${prepo} ${dprepo} ${drepo}"

  if ($repos != "  ") {
    $ensure = present
  } else {
    $ensure = absent
  }

  apt::source { 'puppetlabs':
    ensure     => $ensure,
    location   => 'http://apt.puppetlabs.com',
    repos      => $repos,
    key        => '4BD6EC30',
    key_server => 'pgp.mit.edu',
  }

}
