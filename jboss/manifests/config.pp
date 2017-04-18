class jboss::config inherits jboss {

  group { $jboss_group:
    ensure  =>  present,
    name    =>  $jboss_group
  }

  user { $jboss_user:
    ensure      =>  present,
    name        =>  $jboss_user,
    groups      =>  $jboss_group,
    home        =>  $jboss_home,
    shell       =>  '/bin/bash',
    managehome  =>  false,
  }

  exec { "chown -R ${jboss_user}:${jboss_group} ${jboss_home}/":
    path    =>  ['/usr/bin', '/usr/sbin', ],
  }

  file { '/etc/jboss-as':
    ensure  =>  directory,
  }

  file { '/etc/jboss-as/jboss-as.conf':
    ensure  => file,
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    notify  => Service['jbossas'],
    content => template('jboss/jboss-as.erb'),
  }

  file { '/etc/init.d/jbossas':
    ensure  => file,
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    before  => Service['jbossas'],
    content  => template('jboss/jboss-as-standalone.erb'),
  }
}