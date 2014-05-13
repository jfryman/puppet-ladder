require 'spec_helper'

describe "find_ladder_rungs" do
  context "no facts at all" do
    it "should return no manifests to load" do
      should run.with_params('frymanet_base').and_return([])
    end
  end

  context "one level deep" do
    let(:facts) {
      {
        :virtual => 'xen',
      }
    }
    it "should return one manifests to load" do
      should run.with_params('frymanet_base').and_return(['frymanet::base::platform::xen'])
    end
  end

  context "two levels deep" do
    let(:facts) {
      {
        :operatingsystem => 'Linux',
        :lsbdistcodename => 'Debian',
      }
    }
    it "should return two manifests to load" do
      should run.with_params('frymanet_base').and_return(['frymanet::base::platform::linux', 'frymanet::base::platform::linux::debian'])
    end
  end
end
