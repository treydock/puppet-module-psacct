# See README.md for more details.
class psacct (
  $package_ensure       = 'present',
  $package_name         = $psacct::params::package_name,
  $service_name         = $psacct::params::service_name,
  $service_ensure       = 'running',
  $service_enable       = true,
  $service_hasstatus    = $psacct::params::service_hasstatus,
  $service_hasrestart   = $psacct::params::service_hasrestart,
) inherits psacct::params {

  package { 'psacct':
    ensure => $package_ensure,
    name   => $package_name,
    notify => Service['psacct'],
  }

  service { 'psacct':
    ensure     => $service_ensure,
    enable     => $service_enable,
    name       => $service_name,
    hasstatus  => $service_hasstatus,
    hasrestart => $service_hasrestart,
  }

}
