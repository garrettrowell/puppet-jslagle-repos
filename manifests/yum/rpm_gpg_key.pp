# Imports RPM key - mostly from
# https://github.com/stahnma/puppet-module-puppetlabs_yum/blob/master/manifests/rpm_gpg_key.pp
# Modified to be more general
define repos::yum::rpm_gpg_key () {
  exec { "rpm-import-${name}":
    path      => "/bin:/usr/bin",
    command   => "rpm --import ${name}",
    unless    => "rpm -q gpg-pubkey-$(gpg --throw-keyids <${name} |sed -r 's@^pub\\s+\\w+/(\\w+).*@\\L\\1@;/^sub/d')",
    require   => File[$name],
    logoutput => 'on_failure',
  }
}
