describe user('rsaxvc') do
  it { should exist }
  its('groups') { should include 'rsaxvc' }
  its('groups') { should_not include 'sudo' }
  its('shell') { should eq '/bin/bash' }
end

describe file('/home/rsaxvc/.ssh/authorized_keys') do
  its('content') { should match 'rsaxvc@rsaxvc.net' }
  its('content') { should match 'rsaxvc@gmail.com' }
end
