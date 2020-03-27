# Check stuff that should have been done by user::data_bag
describe user('nick') do
  it { should exist }
  its('groups') { should include 'nick' }
  its('groups') { should include 'sudo' }
  its('shell') { should eq '/usr/bin/zsh' }
end

describe file('/home/nick/.ssh/authorized_keys') do
  its('content') { should match 'nick@polo' }
  its('content') { should match 'mr8= test key' }
end

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
