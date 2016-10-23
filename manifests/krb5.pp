define tomcat::krb5 (
                            $realm,
                            $kdc,
                            $servicename   = $name,
                            $catalina_base = "/opt/${name}",
                          ) {
  #
  validate_array($kdc)

  if($servicename!=undef)
  {
    $serviceinstance=Service[$servicename]
  }
  else
  {
    $serviceinstance=undef
  }

  file { "${catalina_base}/conf/krb5.conf":
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File["${catalina_base}/conf"],
    notify  => $serviceinstance,
    content => template("${module_name}/conf/krb5.erb"),
  }
}