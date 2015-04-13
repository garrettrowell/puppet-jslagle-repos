require 'spec_helper_acceptance'

describe 'repos::yum::asterisk' do
  describe 'using default' do
    it 'should work with no errors' do
      pp ="class { 'repos::yum::asterisk': }"

      apply_manifest(pp, :catch_failures => true)
    end

    describe file('/etc/yum.repos.d/centos-asterisk-11.repo') do
      it { should be_file }
      its(:content) { should match /.*asterisk-11.*baseurl=http:\/\/packages.asterisk.org\/centos\/\$releasever\/asterisk-11\/\$basearch\/.*enabled=1.*/m  }
    end

    describe file('/etc/yum.repos.d/centos-asterisk.repo') do
      it { should be_file }
      its(:content) { should match /.*asterisk-current.*baseurl=http:\/\/packages.asterisk.org\/centos\/\$releasever\/current\/\$basearch\/.*enabled=1.+/m }
    end

    describe file('/etc/yum.repos.d/centos-digium.repo') do
      it { should be_file }
      its(:content) { should match /.*digium-current.*baseurl=http:\/\/packages.digium.com\/centos\/\$releasever\/current\/\$basearch\/.*enabled=1.+/m }
    end

  end
end
