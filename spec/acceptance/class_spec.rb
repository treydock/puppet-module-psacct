require 'spec_helper_acceptance'

describe 'psacct class:' do
  context 'default parameters' do
    it 'should run successfully' do
      pp =<<-EOS
      class { 'psacct': }
      EOS

      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe package('psacct') do
      it { should be_installed }
    end

    describe service('psacct') do
      it { should be_enabled }
      it { should be_running }
    end
  end
end
