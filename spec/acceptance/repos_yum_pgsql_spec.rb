require 'spec_helper_acceptance'

describe 'repos::yum::pgsql' do
  describe 'using default' do
    it 'should work with no errors' do
      pp ="class { 'repos::yum::pgsql': }"

      apply_manifest(pp, :catch_failures => true)
    end

    describe file('/etc/yum.repos.d/pgdg.repo') do
      it { should be_file }
      its(:content) { should match /.*pgdg.*enabled=1.*name=PostgreSQL\s9\.1\s6\s-\sx86_64.*gpgcheck=1.*baseurl=http:\/\/yum\.postgresql\.org\/9\.1\/redhat\/rhel-6-x86_64\/.*gpgkey=file:\/\/\/etc\/pki\/rpm-gpg\/RPM-GPG-KEY-PGDG.*/m  }
    end

    describe file('/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG') do
      it { should be_file }
      it { should be_mode 644 }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
    end
  end
end
