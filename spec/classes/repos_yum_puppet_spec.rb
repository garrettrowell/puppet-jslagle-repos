#!/usr/bin/env rspec
require 'spec_helper'

describe 'repos::yum::puppetlabs' do

  let(:facts) { {:osfamily => 'RedHat', :operatingsystemrelease => '6.2',
    :hardwareisa => 'x86_64' } }

  describe 'Include file' do
    it { should contain_file('/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs').with_ensure('present') }
  end

  describe 'Import key' do
    it { should contain_repos__yum__rpm_gpg_key('/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs') }
  end

  describe 'Yum Repo - Products' do
    it { should contain_yumrepo('puppetlabs-products').with(
      'baseurl' => "http://yum.puppetlabs.com/el/6/products/x86_64",
      'gpgkey'  => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs",
      'descr'   => "Puppet Labs Products El 6 - x86_64"
    )}
  end

end



