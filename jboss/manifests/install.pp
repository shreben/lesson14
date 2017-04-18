# Installation of jboss instance
class jboss::install inherits jboss {

  package { 'java-1.7.0-openjdk':
    ensure => installed,
    name   => 'java-1.7.0-openjdk',
  }

  package { 'java-1.7.0-openjdk-devel':
    ensure => installed,
    name   => 'java-1.7.0-openjdk-devel',
  }

  package { 'unzip':
    ensure => installed,
    name   => 'unzip',
  }

  file { 'jboss-as-7.1.1.Final.zip':
    path   => '/tmp/jboss-as-7.1.1.Final.zip',
    source => $install_source,
  }

  exec { "unzip -o /tmp/jboss-as-7.1.1.Final.zip -d ${install_path}":
    path   => ['/usr/bin', '/usr/sbin', ],
    onlyif => [ '[ ! -f /opt/jboss/current/README.txt ]' ],
  }

  file { $jboss_home:
    ensure => link,
    target => "${install_path}/${install_dir}",
  }
}