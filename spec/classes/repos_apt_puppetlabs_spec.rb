#!/usr/bin/env rspec
require 'spec_helper'

describe 'repos::apt::puppetlabs' do

  let(:facts) { { :hardwareisa => 'x86_64', :lsbdistid => 'Debian',
    :osfamily => 'Debian', :lsbdistcodename => 'quantal',
    :operatingsystemrelease => '12.10' } }

  describe 'Should contain sources' do
    it { should contain_apt__source('puppetlabs').with(
      'ensure' => 'present',
      'location' => 'http://apt.puppetlabs.com',
      'repos' => 'main dependencies ',
      'key' => '4BD6EC30',
      'key_server' => 'pgp.mit.edu'
    )}
  end

end



