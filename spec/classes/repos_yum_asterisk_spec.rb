#!/usr/bin/env rspec
#require 'spec_helper'

describe 'repos::yum::asterisk' do

  let(:params) { {:version => "11"} }
  let(:facts) { {:osfamily => 'RedHat', :operatingsystemmajrelease => '6',
    :hardwareisa => 'x86_64' } }

  describe 'Main Repo' do
    it { should contain_yumrepo('asterisk-11').with(
    'baseurl' => "http://packages.asterisk.org/centos/6/asterisk-11/x86_64/",
    'enabled' => "true",
    'descr'   => "CentOS-6 - Asterisk - 11"
    )}
  end

  describe 'Depend Repo' do
    it { should contain_yumrepo('asterisk-current').with(
    'baseurl' => "http://packages.asterisk.org/centos/6/current/x86_64/",
    'enabled' => "true",
    'descr'   => "CentOS-6 - Asterisk - Current"
    )}
  end

end
