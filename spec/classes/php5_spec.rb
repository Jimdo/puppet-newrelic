describe 'newrelic::php5' do

  some_app_name = 'some_appname'
  default_configpath = '/etc/php5/conf.d/newrelic.ini'

  let (:params ) {
    {
      :appname => some_app_name
    }
  }

  context 'on Debian systems' do

    let (:facts) {
      {
        :osfamily => 'Debian'
      }
    }

    it 'should install the php module' do
      should contain_package('newrelic-php5').with(:ensure => 'installed')
    end

    it 'should notify the webserver after config change' do
    end

    it 'should reload the webserver if defined' do
    end

    context 'with defaults' do

      it 'should configure the php module' do
        should contain_file('/etc/php5/conf.d/newrelic.ini')\
          .with_content(
"extension=newrelic.so
newrelic.appname = #{some_app_name}
newrelic.enabled = true
newrelic.logfile = /var/log/newrelic/php_agent.log
newrelic.loglevel = info
newrelic.browser_monitoring.auto_instrument = 1\n"
        )
      end
    end

    context 'without defaults' do

      let (:params ) {
        {
          :appname => some_app_name,
          :enabled => false,
          :logfile => '/var/log/newrelic/some_log.log',
          :loglevel => 'someloglevel',
          :browser_monitoring_auto_instrument => 0,
          :configpath => '/etc/php5/cgi/conf.d/newrelic.ini'
        }
      }

      it 'should configure the php module' do
        should contain_file('/etc/php5/cgi/conf.d/newrelic.ini')\
.with_content("extension=newrelic.so
newrelic.appname = #{some_app_name}
newrelic.enabled = false
newrelic.logfile = /var/log/newrelic/some_log.log
newrelic.loglevel = someloglevel
newrelic.browser_monitoring.auto_instrument = 0\n"
        )
      end
    end
  end

  context 'with service to notify' do

    let (:params ) {
      {
        :appname => some_app_name,
        :notify_service => 'lighttpd'
      }
    }

    it "should notify a service" do
      should contain_file(default_configpath).with_notify('Service[lighttpd]')
    end

  end

  context 'with not service to notify' do

    let (:params ) {
      {
        :appname => some_app_name
      }
    }

    it "should not notify a service" do
      should contain_file(default_configpath).without_notify('Service')
    end

  end
end
