class newrelic::php5(
  $license_key,
  $appname,
  $notify_service = undef,
  $enabled = true,
  $logfile = '/var/log/newrelic/php_agent.log',
  $loglevel = 'info',
  $browser_monitoring_auto_instrument = 1,
  $configpath = '/etc/php5/conf.d/newrelic.ini'
) {

  include newrelic::repo

  case $::osfamily {
    'Debian': {
      package { 'newrelic-php5' :
        ensure => installed,
        require => Class[newrelic::repo]
      }
    }
  }

  if ($notify_service) {
    file { $configpath :
      notify => Service[$notify_service]
    }
  } else {
    file { $configpath : }
  }

  File[$configpath] {
    ensure => present,
    content => template("newrelic/php5-config.erb")
  }

  service { 'newrelic-daemon':
    enable  => true,
    ensure  => running,
    hasstatus => true,
    hasrestart => true,
    require => Package['newrelic-php5'];
  }

  file { '/etc/newrelic/newrelic.cfg':
    ensure  => present, 
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['newrelic-php5'],
    notify  => Service['newrelic-daemon'],
    content => template('newrelic/newrelic.cfg.erb')
  }
}
