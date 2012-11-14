require 'spec_helper'

describe 'repos::yum::rpm_gpg_key' do

  let(:title) {'/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG'}
  it { should contain_exec('rpm-import-/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG').
    with_command("rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG")  }

end
