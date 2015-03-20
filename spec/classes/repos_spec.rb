#!/usr/bin/env rspec
require 'spec_helper'

describe 'repos' do

  describe 'Redhat repos enabled' do
    let(:facts) { { :osfamily => 'RedHat', :operatingsystemrelease => '6.2',
      :hardwareisa => 'x86_64'
    } }

    let(:params) { { :enablepuppetlabs => "true",
      :enablepgsql => "true" } }

    describe 'Include pgsql' do
      it { should contain_class("repos::yum::pgsql") }
    end

    describe 'Include puppetlabs' do
      it { should contain_class("repos::yum::puppetlabs") }
    end
  end

  describe 'Redhat default params' do
    let(:facts) { { :osfamily => 'RedHat', :operatingsystemrelease => '6.2',
      :hardwareisa => 'x86_64'
    } }

    describe 'Include pgsql' do
      it { should_not contain_class("repos::yum::pgsql") }
    end

    describe 'Include puppetlabs' do
      it { should_not contain_class("repos::yum::puppetlabs") }
    end
  end


  describe 'Ubuntu enable puppet' do
    let(:facts) { {:osfamily => 'Debian', :lsbdistcodename => 'precise',
      :hardwareisa => 'x86_64', :lsbdistid => 'Debian',
      :operatingsystemrelease => '12.04'
    } }

    let(:params) { { :enablepuppetlabs => "true" } }

    describe 'Include puppetlabs' do
      it { should contain_class("repos::apt::puppetlabs") }
    end
  end

  describe 'Ubuntu default params' do
    let(:facts) { {:osfamily => 'Debian', :lsbdistcodename => 'precise',
      :hardwareisa => 'x86_64', :lsbdistid => 'Debian',
      :operatingsystemrelease => '12.04'
    } }


    describe 'Include puppetlabs' do
      it { should_not contain_class("repos::apt::puppetlabs") }
    end
  end

end



