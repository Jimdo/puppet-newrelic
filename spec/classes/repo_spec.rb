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
      should contain_apt__source('newrelic')
    end
end

end
