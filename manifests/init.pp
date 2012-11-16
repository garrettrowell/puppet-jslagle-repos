# == Class: repos
#
# Full description of class repos here.
#
# === Parameters
#
# Document parameters here.
#
# enablepuppetlabs
#   Indication whether to enabled the puppet repos.
#   Specified as a true/false string due to a bug in Hiera
#     - Bug at http://projects.puppetlabs.com/issues/17105
#
# enablepgsql
#   Indicates whether to include the pgsql repos - defaults
#   to version 9.1, but can be changed in Hiera.
#   Boolean string
#
# === Examples
#
# include repos
#
# === Authors
#
# Jason Slagle <jslagle@gmail.com>
#
# === Copyright
#
# Copyright 2012 Jason Slagle, unless otherwise noted.
#
class repos (
  $enablepuppetlabs = "false",
  $enablepgsql = "false"
) {
  include stdlib

  $renablepuppetlabs = str2bool($enablepuppetlabs)
  $renablepgsql = str2bool($enablepgsql)

  if ($renablepuppetlabs) {
    include repos::puppetlabs
  }

  if ($renablepgsql) {
    include repos::pgsql
  }

}
