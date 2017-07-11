# puppet2sitepp @tomcatcontext
define tomcat::context(
                        $path,
                        $servicename           = $name,
                        $catalina_base         = "/opt/${name}",
                        $docbase               = undef,
                        $reloadable            = true,
                      ) {

  if ! defined(Class['tomcat'])
  {
    fail('You must include the tomcat base class before using any tomcat defined resources')
  }

  concat::fragment{ "${catalina_base}/conf/server.xml context ${name} ${catalina_base} ${servicename} ${path}":
    target  => "${catalina_base}/conf/server.xml",
    order   => '26',
    content => template("${module_name}/conf/context.erb"),
  }

}
