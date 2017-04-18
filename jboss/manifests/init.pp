# Class: jboss
# ===========================
#
# Full description of class jboss here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'jboss':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class jboss (

  $install_path   = $::jboss::params::install_path,
  $jboss_home     = $::jboss::params::jboss_home,
  $jboss_user     = $::jboss::params::jboss_user,
  $jboss_group    = $::jboss::params::jboss_group,
  $artefact       = $::jboss::params::artefact,
  $listen_address = $::jboss::params::listen_address,

) inherits ::jboss::params {

  $install_source       = 'puppet:///modules/jboss/jboss-as-7.1.1.Final.zip'
  $init_script_template = 'jboss-as-standalone.sh'
  $init_config_template = 'jboss-as.conf'
  $data_dir             = "${jboss_home}/standalone/deployments"
  $install_dir          = 'jboss-as-7.1.1.Final'
  $artefact_source      = "puppet:///modules/jboss/${artefact}"

  ### Managed resources
  include ::jboss::install
  include ::jboss::config
  include ::jboss::service
  include ::jboss::deploy

  Class['jboss::install'] -> Class['jboss::config']
  Class['jboss::config'] -> Class['jboss::service']
  #Class['jboss::service'] -> Class['jboss::deploy']

}
