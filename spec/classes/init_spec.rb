require 'spec_helper'

describe 'psacct' do
  on_supported_os({
    :supported_os => [
      {
        "operatingsystem" => "RedHat",
        "operatingsystemrelease" => ["6", "7"],
      }
    ]
  }).each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts.merge({
          :concat_basedir => '/dne',
        })
      end

      it { is_expected.to compile.with_all_deps }

      it { is_expected.to create_class('psacct') }
      it { is_expected.to contain_class('psacct::params') }

      it do
        is_expected.to contain_package('psacct').only_with({
          :ensure => 'present',
          :name   => 'psacct',
          :notify => 'Service[psacct]',
        })
      end

      it do
        is_expected.to contain_service('psacct').only_with({
          :ensure      => 'running',
          :enable      => 'true',
          :name        => 'psacct',
          :hasstatus   => 'true',
          :hasrestart  => 'true',
        })
      end

      # Test validate_bool parameters
      [

      ].each do |param|
        context "with #{param} => 'foo'" do
          let(:params) {{ param.to_sym => 'foo' }}
          it 'should raise an error' do
            expect { is_expected.to compile }.to raise_error(/is not a boolean/)
          end
        end
      end

    end # end context
  end # end on_supported_os loop
end # end describe
