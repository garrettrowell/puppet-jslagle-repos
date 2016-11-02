#!/usr/bin/env rspec
require 'spec_helper'

describe 'repos::yum::epel' do

  let(:facts) do
    {
      :os => {
        :family   => 'RedHat',
        :name     => 'Scientific',
        :hardware => 'x86_64',
        :release  => {
          :full  => '6.6',
          :major => '6',
          :minor => '6'
        }
      }
    }
  end

  describe 'Include file' do
    it do
      is_expected.to contain_file('/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6').with(
        'ensure' => 'present'
      )
    end
  end

  describe 'Import key' do
    it do
      is_expected.to contain_repos__yum__rpm_gpg_key('/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6')
    end
  end

  describe 'Yum Repo - Base' do
    it do
      is_expected.to contain_yumrepo('epel').with(
        'baseurl' => "http://download.fedoraproject.org/pub/epel/6/x86_64",
        'gpgkey'  => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6",
        'descr'   => "Extra Packages for Enterprise Linux 6 - x86_64",
        'enabled' => 1
      )
    end
  end

  describe 'Yum Repo - Testing' do
    it do
      is_expected.to contain_yumrepo('epel-testing').with(
        'baseurl' => "http://download.fedoraproject.org/pub/epel/testing/6/x86_64",
        'gpgkey'  => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6",
        'descr'   => "Extra Packages for Enterprise Linux 6 - Testing - x86_64",
        'enabled' => 1
      )
    end
  end
end
