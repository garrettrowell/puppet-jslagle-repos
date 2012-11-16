#!/usr/bin/env rspec
require 'spec_helper'

describe 'repos' do

  let(:params) { {:enablepuppetlabs => "true",
    :enablepgsql => "true"
  } }

  let(:facts) { {:osfamily => 'RedHat', :operatingsystemrelease => '6.2',
    :hardwareisa => 'x86_64'
  } }

  describe 'Include pgsql' do
    it { should include_class("repos::yum::pgsql") }
  end

  describe 'Include puppetlabs' do
    it { should include_class("repos::yum::puppetlabs") }
  end

end



