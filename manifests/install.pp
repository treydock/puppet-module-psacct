# Private class.
class psacct::install {
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  package { 'psacct':
    ensure => $psacct::package_ensure,
    name   => $psacct::package_name,
  }

}
