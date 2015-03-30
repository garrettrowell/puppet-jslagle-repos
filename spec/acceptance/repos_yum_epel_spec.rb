require 'spec_helper_acceptance'

describe 'repos::yum::epel' do
  describe 'using default' do
    it 'should work with no errors' do
      pp ="class { 'repos::yum::epel': }"

      apply_manifest(pp, :catch_failures => true)
    end

    describe file('/etc/yum.repos.d/epel.repo') do
      it { should be_file }
      its(:content) { should match /.*epel.*enabled=1.*baseurl=http:\/\/download.fedoraproject.org\/pub\/epel\/6\/x86_64.*gpgcheck=1.*gpgkey=file:\/\/\/etc\/pki\/rpm-gpg\/RPM-GPG-KEY-EPEL-6/m  }
    end

    describe file('/etc/yum.repos.d/epel-testing.repo') do
      it { should be_file }
      its(:content) { should match /.*epel-testing.*enabled=1.*baseurl=http:\/\/download.fedoraproject.org\/pub\/epel\/testing\/6\/x86_64.*gpgcheck=1.*gpgkey=file:\/\/\/etc\/pki\/rpm-gpg\/RPM-GPG-KEY-EPEL-6/m }
    end

    describe file('/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6') do
      it { should be_file }
      it { should be_mode 644 }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
    end
  end
end
