require 'spec_helper_acceptance'

describe 'repos::yum::asterisk' do
  describe 'using default' do
    it 'should work with no errors' do
      pp ="class { 'repos::yum::asterisk': }"

      apply_manifest(pp, :catch_failures => true)
    end

    describe file('/etc/yum.repos.d/asterisk-11.repo') do
      it { should be_file }
      its(:content) { should match /.*asterisk-11.*enabled=true.*baseurl=http:\/\/packages.asterisk.org\/centos\/6\/asterisk-11\/x86_64\//m  }
    end

    describe file('/etc/yum.repos.d/asterisk-current.repo') do
      it { should be_file }
      its(:content) { should match /.*asterisk-current.*enabled=true.*baseurl=http:\/\/packages.asterisk.org\/centos\/6\/current\/x86_64\//m }
    end

    describe file('/etc/yum.repos.d/digium-current.repo') do
      it { should be_file }
      its(:content) { should match /.*digium-current.*enabled=true.*baseurl=http:\/\/packages.digium.com\/centos\/6\/current\/x86_64\//m }
    end

  end
end
