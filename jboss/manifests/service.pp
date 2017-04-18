# Manage jboss service
class jboss::service {
  service { 'jbossas':
    ensure     => running,
    name       => 'jbossas',
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
#    require    => Class['jboss::install', 'jboss::config']
  }
}