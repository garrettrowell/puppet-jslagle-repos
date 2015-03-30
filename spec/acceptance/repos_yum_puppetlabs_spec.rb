require 'spec_helper_acceptance'

describe 'repos::yum::puppetlabs' do
  describe 'using default' do
    it 'should work with no errors' do
      pp ="class { 'repos::yum::puppetlabs': }"

      apply_manifest(pp, :catch_failures => true)
    end

    describe file('/etc/yum.repos.d/puppetlabs-products.repo') do
      it { should be_file }
      its(:content) { should match /.*puppetlabs-products.*name=Puppet\sLabs\sProducts\sEl\s6\s-\sx86_64.*baseurl=http:\/\/yum\.puppetlabs\.com\/el\/6\/products\/x86_64.*enabled=1.*gpgcheck=1.*gpgkey=file:\/\/\/etc\/pki\/rpm-gpg\/RPM-GPG-KEY-puppetlabs.*/m  }
    end

    describe file('/etc/yum.repos.d/puppetlabs-deps.repo') do
      it { should be_file }
      its(:content) { should match /.*puppetlabs-deps.*name=Puppet\sLabs\sDependencies\sEl\s6\s-\sx86_64.*baseurl=http:\/\/yum\.puppetlabs\.com\/el\/6\/dependencies\/x86_64.*enabled=1.*gpgcheck=1.*gpgkey=file:\/\/\/etc\/pki\/rpm-gpg\/RPM-GPG-KEY-puppetlabs.*/m  }
    end

    describe file('/etc/yum.repos.d/puppetlabs-devel.repo') do
      it { should be_file }
      its(:content) { should match /.*puppetlabs-devel.*name=Puppet\sLabs\sDevel\sEl\s6\s-\sx86_64.*baseurl=http:\/\/yum\.puppetlabs\.com\/el\/6\/devel\/x86_64.*enabled=0.*gpgcheck=1.*gpgkey=file:\/\/\/etc\/pki\/rpm-gpg\/RPM-GPG-KEY-puppetlabs.*/m  }
    end

    describe file('/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs') do
      it { should be_file }
      it { should be_mode 644 }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
    end
  end
end
