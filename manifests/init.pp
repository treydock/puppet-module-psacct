# See README.md for more details.
class psacct (
  $package_ensure       = 'present',
  $package_name         = $psacct::params::package_name,
  $retention            = 31,
  $service_name         = $psacct::params::service_name,
  $service_ensure       = 'running',
  $service_enable       = true,
  $service_hasstatus    = $psacct::params::service_hasstatus,
  $service_hasrestart   = $psacct::params::service_hasrestart,
) inherits psacct::params {

  if $facts['service_provider'] == 'systemd' {
    $logrotate_postrotate = [
      'if /usr/bin/systemctl --quiet is-active psacct.service ; then',
      '  /usr/sbin/accton /var/account/pacct | /usr/bin/grep -v "Turning on process accounting, file set to \'/var/account/pacct\'." | /usr/bin/cat',
      'fi',
    ]
  } else {
    $logrotate_postrotate = [
      'if [ -f /var/lock/subsys/psacct ]; then',
      '  /usr/sbin/accton /var/account/pacct',
      'fi',
    ]
  }

  package { 'psacct':
    ensure => $package_ensure,
    name   => $package_name,
    notify => Service['psacct'],
  }

  logrotate::rule { 'psacct':
    path          => '/var/account/pacct',
    compress      => true,
    delaycompress => true,
    ifempty       => false,
    rotate_every  => 'day',
    rotate        => $retention,
    create        => true,
    create_mode   => '0600',
    create_owner  => 'root',
    create_group  => 'root',
    postrotate    => $logrotate_postrotate,
    require       => Package['psacct'],
  }

  service { 'psacct':
    ensure     => $service_ensure,
    enable     => $service_enable,
    name       => $service_name,
    hasstatus  => $service_hasstatus,
    hasrestart => $service_hasrestart,
  }

}
