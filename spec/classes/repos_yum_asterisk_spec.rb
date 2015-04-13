#!/usr/bin/env rspec
#require 'spec_helper'

describe 'repos::yum::asterisk' do

  let(:facts) { {:osfamily => 'RedHat', :operatingsystemmajrelease => '6',
    :hardwareisa => 'x86_64' } }

  describe 'Main Repo' do
    it { should contain_yumrepo('asterisk-11').with_enabled("1") }
  end

  describe 'Dependencies' do
    it { should contain_package('dnsmasq') }

    it { should contain_package('asterisknow-version').with(
      'require' => 'Package[dnsmasq]', 'provider' => 'rpm',
      'ensure' => 'installed')
    }
  end

end
