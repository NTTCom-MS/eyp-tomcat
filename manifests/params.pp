class tomcat::params() {

	$develpkg=[ 'apr-devel' ]

	case $::osfamily
	{
    'redhat':
    {
      case $::operatingsystemrelease
      {
        /^[5-6].*$/:
        {
        }
        default: { fail("Unsupported RHEL/CentOS version! - $::operatingsystemrelease")  }
      }
    }
		'Debian':
		{
			case $::operatingsystem
			{
				'Ubuntu':
				{
					case $::operatingsystemrelease
					{
						/^14.*$/:
						{
						}
						default: { fail("Unsupported Ubuntu version! - $::operatingsystemrelease")  }
					}
				}
				'Debian': { fail('Unsupported')  }
				default: { fail('Unsupported Debian flavour!')  }
			}
		}
		default: { fail('Unsupported OS!')  }
	}
}
