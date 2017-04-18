class jboss::deploy inherits jboss {

  file { "/tmp/${artefact}":
    path    =>  "/tmp/${artefact}",
    source  =>  $artefact_source,
  }

  exec { "unzip -o /tmp/${artefact} -d ${data_dir}":
    path    => ['/usr/bin', '/usr/sbin', ],
    notify  => Service[jbossas],
  }
}