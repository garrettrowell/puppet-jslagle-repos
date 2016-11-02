require 'spec_helper'

describe 'repos::yum::rpm_gpg_key' do

  let(:title) {'/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG'}

  it do
    is_expected.to contain_exec('rpm-import-/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG').with(
      'command' => 'rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG',
      'path'    => '/bin:/usr/bin',
      'logoutput' => 'on_failure',
      'unless' => 'rpm -q gpg-pubkey-$(gpg --throw-keyids </etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG |sed -r \'s@^pub\\s+\\w+/(\\w+).*@\\L\\1@;/^sub/d\')',
      'require' => 'File[/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG]'
    )
  end

end
