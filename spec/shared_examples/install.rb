shared_context "psacct::install" do
  it do
    is_expected.to contain_package('psacct').only_with({
      :ensure => 'present',
      :name   => 'psacct',
    })
  end
end
