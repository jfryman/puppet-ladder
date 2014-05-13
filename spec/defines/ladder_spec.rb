require 'spec_helper'

describe "ladder" do
  let(:title) { 'frymanet_base' }

  context "no matches" do
    it "should fail open" do
      should contain_notify("Unable to load the ladder frymanet_base. No manifests found.")
    end
  end

  context "matches" do
    let(:facts) {
      {
        :operatingsystem => 'Linux',
        :lsbdistcodename => 'Ubuntu',
        :datacenter      => 'dc1',
        :virtual         => 'physical',
      }
    }
    it "should load four manifests based on fixture" do
      should contain_class('frymanet::base::platform::linux')
      should contain_class('frymanet::base::platform::linux::ubuntu')
      should contain_class('frymanet::base::platform::physical')      
      should contain_class('frymanet::base::platform::dc1::linux')
    end
  end
end
