require 'spec_helper_acceptance'

describe 'install_puppet_agent.sh with version argument' do

  describe command('bash -c "/var/tmp/puppet-install-shell/install_puppet_agent.sh -v 4.5.3"') do
    if os[:family] == 'redhat'
      its(:stdout) { should match /Red hat like platform! Lets get you an RPM.../ }
      its(:stdout) { should match /installing puppetlabs yum repo with rpm.../ }
    end
    if os[:family] == 'debian'
      its(:stdout) { should match /Debian platform! Lets get you a DEB.../ }
      its(:stdout) { should match /installing puppetlabs apt repo with dpkg.../ }
    end
    its(:stdout) { should match /Version parameter defined: 4.5.3/ }
    its(:stdout) { should match /puppet/ }
    its(:exit_status) { should eq 0 }
  end

  describe command('/opt/puppetlabs/bin/puppet --version') do
    its(:stdout) { should match /^4\.5\.3/ }
    its(:stderr) { should be_empty }
  end

end
