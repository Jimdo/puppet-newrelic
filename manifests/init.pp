define newrelic($license_key = $title) {

  Class['newrelic::repo']
    ~>Class['newrelic::package']
    ~>Class['newrelic::server']

  include newrelic::repo
  include newrelic::package
  class { 'newrelic::server' :
    license_key => $license_key
  }
}
