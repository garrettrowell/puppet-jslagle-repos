#!/usr/bin/env rspec
require 'spec_helper'

describe 'repos::apt::puppetlabs' do
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

  describe 'Should contain sources' do
    it do
      is_expected.to contain_apt__source('puppetlabs').with(
        'ensure'     => 'present',
        'location'   => 'http://apt.puppetlabs.com',
        'repos'      => 'main dependencies',
        'key'        => '4BD6EC30',
        'key_server' => 'pgp.mit.edu'
      )
    end
  end
end
