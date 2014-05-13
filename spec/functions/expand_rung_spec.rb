require 'spec_helper'

describe "expand_rung" do
  context "single variable" do
    let(:facts) {
      {
        :virtual => 'xen',
      }
    }
    it "should return a populated value" do
      should run.with_params('platform/%{::virtual}').and_return('platform/xen')
    end
  end

  context "two layers" do
    let(:facts) {
      {
        :operatingsystem => 'Linux',
        :lsbdistcodename => 'Debian',
      }
    }
    it "should return a populated value" do
      should run.with_params('platform/%{::operatingsystem}/%{::lsbdistcodename}').and_return('platform/linux/debian')
    end
  end
end
