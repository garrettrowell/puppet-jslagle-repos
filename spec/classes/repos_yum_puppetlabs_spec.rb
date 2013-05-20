#!/usr/bin/env rspec
require 'spec_helper'

describe 'repos::yum::puppetlabs' do

  let(:facts) { {:osfamily => 'RedHat', :operatingsystemrelease => '6.2',
    :architecture => 'x86_64' } }

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
      'descr'   => "Puppet Labs Products El 6 - x86_64",
      'enabled' => 1
    )}
  end

  describe 'Yum Repo - Dependencies' do
    it { should contain_yumrepo('puppetlabs-deps').with(
      'baseurl' => "http://yum.puppetlabs.com/el/6/dependencies/x86_64",
      'gpgkey'  => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs",
      'descr'   => "Puppet Labs Dependencies El 6 - x86_64",
      'enabled' => 1
    )}
  end

  describe 'Yum repo - no devel' do
    it { should contain_yumrepo('puppetlabs-devel').with(
      'enabled' => 0
    )}
  end

  describe 'Enable devel' do
    let(:params) {{ :enabledevel => true }}
    describe 'Yum Repo - devel' do
      it { should contain_yumrepo('puppetlabs-devel').with(
        'baseurl' => "http://yum.puppetlabs.com/el/6/devel/x86_64",
        'gpgkey'  => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs",
        'descr'   => "Puppet Labs Devel El 6 - x86_64",
        'enabled' => 1
      )}
    end
  end

  describe 'i386' do
    let(:facts) { { :osfamily => 'RedHat', :operatingsystemrelease => '6.2',
      :architecture => 'i686' } }
    it { should contain_yumrepo('puppetlabs-products').with(
      'baseurl' => "http://yum.puppetlabs.com/el/6/products/i386",
      'gpgkey'  => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs",
      'descr'   => "Puppet Labs Products El 6 - i386",
      'enabled' => 1
    )}
  end
end



