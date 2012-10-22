require 'spec_helper'

describe 'newrelic::sysmond' do

  some_license_key = '0c3b79d7387aaaa2103ab38ae41577fc45141741'

  let(:params) { { :license_key => some_license_key  } }

  it "should install the package" do
    should contain_package('newrelic-sysmond').with({
      :ensure => 'installed',
      :require => 'Class[Newrelic::Repo]'
    })
  end

  it "should contain the repository" do
    should include_class('newrelic::repo')
  end

  it "should pass the license_key correctly" do
    should contain_exec('newrelic-set-license').with(
      {
        :command => "nrsysmond-config --set license_key=#{some_license_key}"
      }
    )
  end

end
