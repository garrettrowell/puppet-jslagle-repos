#!/usr/bin/env rspec
require 'spec_helper'

describe 'repos::yum::pgsql' do

  let(:params) { {:version => "9.1"} }
  let(:facts) { {:osfamily => 'RedHat', :operatingsystemrelease => '6.2',
    :hardwareisa => 'x86_64' } }

  describe 'Include file' do
    it { should contain_file('/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG').with_ensure('present') }
  end

  describe 'Import key' do
    it { should contain_repos__yum__rpm_gpg_key('/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG') }
  end

  describe 'Yum Repo' do
    it { should contain_yumrepo('pgdg').with(
      'baseurl' => "http://yum.postgresql.org/9.1/redhat/rhel-6-x86_64/",
      'gpgkey'  => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG",
      'descr'   => "PostgreSQL 9.1 6 - x86_64"
    )}
  end

end



