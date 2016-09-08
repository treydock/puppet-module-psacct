shared_context "psacct::service" do
  it do
    is_expected.to contain_service('psacct').only_with({
      :ensure      => 'running',
      :enable      => 'true',
      :name        => 'psacct',
      :hasstatus   => 'true',
      :hasrestart  => 'true',
    })
  end
end
