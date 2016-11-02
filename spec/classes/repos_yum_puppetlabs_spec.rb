#!/usr/bin/env rspec
require 'spec_helper'

describe 'repos::yum::puppetlabs' do
  let(:facts) do
    {
      :operatingsystemrelease => '6.6',
      :os                     => {
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
      is_expected.to contain_file('/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs').with(
        'ensure' => 'present',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644'
      )
    end
  end

  describe 'Import key' do
    it do
      is_expected.to contain_repos__yum__rpm_gpg_key('/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs')
    end
  end

  describe 'Yum Repo - Products' do
    it do
      is_expected.to contain_yumrepo('puppetlabs-products').with(
        'baseurl' => 'http://yum.puppetlabs.com/el/6/products/x86_64',
        'gpgkey'  => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
        'descr'   => 'Puppet Labs Products El 6 - x86_64',
        'enabled' => 1
      )
    end
  end

  describe 'Yum Repo - Dependencies' do
    it do
      is_expected.to contain_yumrepo('puppetlabs-deps').with(
        'baseurl' => 'http://yum.puppetlabs.com/el/6/dependencies/x86_64',
        'gpgkey'  => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
        'descr'   => 'Puppet Labs Dependencies El 6 - x86_64',
        'enabled' => 1
      )
    end
  end

  describe 'Yum repo - no devel' do
    it do
      is_expected.to contain_yumrepo('puppetlabs-devel').with(
        'enabled' => 0
      )
    end
  end

  describe 'Enable devel' do
    let(:params) do
      {
        :enabledevel => true
      }
    end

    describe 'Yum Repo - devel' do
      it do
        is_expected.to contain_yumrepo('puppetlabs-devel').with(
          'baseurl' => 'http://yum.puppetlabs.com/el/6/devel/x86_64',
          'gpgkey'  => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
          'descr'   => 'Puppet Labs Devel El 6 - x86_64',
          'enabled' => 1
        )
      end
    end
  end

  describe 'i386' do
    let(:facts) do
      {
        :os => {
          :family   => 'RedHat',
          :name     => 'Scientific',
          :hardware => 'i686',
          :release  => {
            :full  => '6.6',
            :major => '6',
            :minor => '6'
          }
        }
      }
    end

    it do
      is_expected.to contain_yumrepo('puppetlabs-products').with(
        'baseurl' => 'http://yum.puppetlabs.com/el/6/products/i386',
        'gpgkey'  => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
        'descr'   => 'Puppet Labs Products El 6 - i386',
        'enabled' => 1
      )
    end
  end
end
