# Private class.
class psacct::service {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  service { 'psacct':
    ensure     => $psacct::service_ensure,
    enable     => $psacct::service_enable,
    name       => $psacct::service_name,
    hasstatus  => $psacct::service_hasstatus,
    hasrestart => $psacct::service_hasrestart,
  }

}
