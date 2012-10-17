describe "newrelic" do

  some_license_key = '0c3b79d7387aaaa2103ab38ae41577fc45141741'

  let(:params) { { :license_key => some_license_key  } }

  it "should contain the subclasses" do
    should include_class('newrelic::repo')
    should include_class('newrelic::package')
    should include_class('newrelic::server')
  end

  it "should pass the license_key correctly" do
    should contain_exec('newrelic-set-license').with(
      {
        :command => "nrsysmond-config --set license_key=#{some_license_key}"
      }
    )
  end

end
