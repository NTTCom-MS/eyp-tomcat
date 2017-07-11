# puppet2sitepp @tomcatcontextxml
define tomcat::contextxml (
                            $session_cookie_path   = undef,
                            $session_cookie_name   = undef,
                            $watched_resource      = 'WEB-INF/web.xml',
                            $manager               = undef,
                            $anti_jar_locking      = undef,
                            $anti_resource_locking = undef,
                            $servicename           = $name,
                            $catalina_base         = "/opt/${name}",
                            $path                  = undef,
                          ) {

  if ! defined(Class['tomcat'])
  {
    fail('You must include the tomcat base class before using any tomcat defined resources')
  }

  #validate_array($ldapservers)
  #validate_string($ldapbase)

  if($servicename!=undef)
  {
    $serviceinstance=Tomcat::Instance::Service[$servicename]
  }
  else
  {
    $serviceinstance=undef
  }

  concat { "${catalina_base}/conf/context.xml":
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => File["${catalina_base}/conf"],
    notify  => $serviceinstance,
  }

  concat::fragment{ "${catalina_base}/conf/context.xml header":
    target  => "${catalina_base}/conf/context.xml",
    order   => '00',
    content => template("${module_name}/conf/contextxml.erb"),
  }

  concat::fragment{ "${catalina_base}/conf/server.xml fi context":
    target  => "${catalina_base}/conf/context.xml",
    order   => '99',
    content => "</Context>\n",
  }
}
