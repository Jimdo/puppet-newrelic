class newrelic::php5(
  $appname,
  $notify_service = undef,
  $enabled = true,
  $logfile = '/var/log/newrelic/php_agent.log',
  $loglevel = 'info',
  $browser_monitoring_auto_instrument = 1,
  $configpath = '/etc/php5/conf.d/newrelic.ini'
) {
  case $::osfamily {
    'Debian': {
      package { 'newrelic-php5' :
        ensure => installed
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
}
