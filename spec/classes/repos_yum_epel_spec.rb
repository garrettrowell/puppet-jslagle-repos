#!/usr/bin/env rspec
require 'spec_helper'

describe 'repos::yum::epel' do

  let(:facts) { {:osfamily => 'RedHat', :operatingsystemrelease => '6.2',
    :architecture => 'x86_64' } }

  describe 'Include file' do
    it { should contain_file('/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6').with_ensure('present') }
  end

  describe 'Import key' do
    it { should contain_repos__yum__rpm_gpg_key('/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6') }
  end

  describe 'Yum Repo - Base' do
    it { should contain_yumrepo('epel').with(
      'baseurl' => "http://download.fedoraproject.org/pub/epel/6/x86_64",
      'gpgkey'  => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6",
      'descr'   => "Extra Packages for Enterprise Linux 6 - x86_64",
      'enabled' => 1
    )}
  end

  describe 'Yum Repo - Testing' do
    it { should contain_yumrepo('epel-testing').with(
      'baseurl' => "http://download.fedoraproject.org/pub/epel/testing/6/x86_64",
      'gpgkey'  => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6",
      'descr'   => "Extra Packages for Enterprise Linux 6 - Testing - x86_64",
      'enabled' => 1
    )}
  end

end



