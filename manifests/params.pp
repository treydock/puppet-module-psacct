# Private class.
class psacct::params {

  case $::osfamily {
    'RedHat': {
      $package_name       = 'psacct'
      $service_name       = 'psacct'
      $service_hasstatus  = true
      $service_hasrestart = true
    }

    default: {
      fail("Unsupported osfamily: ${::osfamily}, module ${module_name} only support osfamily RedHat")
    }
  }

}
