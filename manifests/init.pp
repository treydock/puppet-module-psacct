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

  include psacct::install
  include psacct::config
  include psacct::service

  anchor { 'psacct::start': }->
  Class['psacct::install']->
  Class['psacct::config']~>
  Class['psacct::service']->
  anchor { 'psacct::end': }

}
