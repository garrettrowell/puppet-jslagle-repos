#!/usr/bin/env rspec
require 'spec_helper'

describe 'repos::yum::pgsql' do
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

  let(:params) do
    {
      :version => '9.1'
    }
  end

  describe 'Include file' do
    it do
      is_expected.to contain_file('/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG').with(
        'ensure' => 'present'
      )
    end
  end

  describe 'Import key' do
    it do
      is_expected.to contain_repos__yum__rpm_gpg_key('/etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG')
    end
  end

  describe 'Yum Repo' do
    it do
      is_expected.to contain_yumrepo('pgdg').with(
        'baseurl' => "http://yum.postgresql.org/9.1/redhat/rhel-6-x86_64/",
        'gpgkey'  => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-PGDG",
        'descr'   => "PostgreSQL 9.1 6 - x86_64"
      )
    end
  end
end
