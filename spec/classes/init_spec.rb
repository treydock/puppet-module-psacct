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

      it { is_expected.to contain_anchor('psacct::start').that_comes_before('Class[psacct::install]') }
      it { is_expected.to contain_class('psacct::install').that_comes_before('Class[psacct::config]') }
      it { is_expected.to contain_class('psacct::config').that_notifies('Class[psacct::service]') }
      it { is_expected.to contain_class('psacct::service').that_comes_before('Anchor[psacct::end]') }
      it { is_expected.to contain_anchor('psacct::end') }

      include_context 'psacct::install'
      include_context 'psacct::config'
      include_context 'psacct::service'

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
