#!/usr/bin/env rspec
#require 'spec_helper'

describe 'repos::yum::asterisk' do

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

  describe 'Main Repo' do
    it do
      is_expected.to contain_yumrepo('asterisk-11').with(
        'enabled' => '1'
      )
    end
  end

  describe 'Dependencies' do
    it do
      is_expected.to contain_package('dnsmasq')
    end

    it do
      is_expected.to contain_package('asterisknow-version').with(
        'require'  => 'Package[dnsmasq]',
        'provider' => 'rpm',
        'ensure'   => 'installed'
      )
    end
  end
end
