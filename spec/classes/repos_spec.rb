#!/usr/bin/env rspec
require 'spec_helper'

describe 'repos' do

  describe 'Redhat repos enabled' do
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
        :enablepuppetlabs => true,
        :enablepgsql      => true
      }
    end

    describe 'Include pgsql' do
      it do
        is_expected.to contain_class('repos::yum::pgsql')
      end
    end

    describe 'Include puppetlabs' do
      it do
        is_expected.to contain_class('repos::yum::puppetlabs')
      end
    end
  end

  describe 'Redhat default params' do
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

    describe 'Include pgsql' do
      it do
        is_expected.not_to contain_class('repos::yum::pgsql')
      end
    end

    describe 'Include puppetlabs' do
      it do
        is_expected.not_to contain_class('repos::yum::puppetlabs')
      end
    end
  end

  describe 'Ubuntu enable puppet' do
    let(:facts) do
      {
        :os              => {
          :family   => 'Debian',
          :name     => 'Debian',
          :hardware => 'x86_64',
          :release  => {
            :full  => '12.04',
            :major => '12.04',
          },
          :lsb      => {
            :distcodename => 'precise',
            :distid       => 'Debian'
          }
        },
        :osfamily        => 'Debian',
        :puppetversion   => '4',
        :lsbdistid       => 'Debian',
        :lsbdistcodename => 'precise'
      }
    end

    let(:params) do
      {
        :enablepuppetlabs => true
      }
    end

    describe 'Include puppetlabs' do
      it do
        is_expected.to contain_class('repos::apt::puppetlabs')
      end
    end
  end

  describe 'Ubuntu default params' do
    let(:facts) do
      {
        :os              => {
          :family   => 'Debian',
          :name     => 'Debian',
          :hardware => 'x86_64',
          :release  => {
            :full  => '12.04',
            :major => '12.04',
          },
          :lsb      => {
            :distcodename => 'precise',
            :distid       => 'Debian'
          }
        },
        :osfamily        => 'Debian',
        :puppetversion   => '4',
        :lsbdistid       => 'Debian',
        :lsbdistcodename => 'precise'
      }
    end

    describe 'Include puppetlabs' do
      it do
        is_expected.not_to contain_class('repos::apt::puppetlabs')
      end
    end
  end
end
