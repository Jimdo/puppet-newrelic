require 'spec_helper'

describe 'newrelic::repo' do

  context "with debianish env" do

    let(:facts) {
      {
        :operatingsystem => 'Debian',
        :lsbdistcodename => 'squeeze',

      }
    }

    it "should add the repo" do
      should contain_apt__source('newrelic').with({
        :location    => "http://apt.newrelic.com/debian/",
        :release     => "newrelic",
        :repos       => "non-free",
        :key         => "548C16BF",
        :key_server  => "keyserver.ubuntu.com",
        :include_src => false
      })
    end
end

end
