# Check stuff that should have been done by user::data_bag
describe user('nick') do
  it { should exist }
  its('groups') { should include 'nick' }
  its('groups') { should include 'sudo' }
  its('shell') { should eq '/usr/bin/zsh' }
end

describe file('/home/nick/.ssh/authorized_keys') do
  its('content') { should match 'nicks_ssh_key' }
end

describe shadow.where(user: 'nick') do
  its('passwords.uniq') { should include 'totally_legit_password_hash' }
end

describe user('rsaxvc') do
  it { should exist }
  its('groups') { should include 'rsaxvc' }
  its('groups') { should_not include 'sudo' }
  its('shell') { should eq '/bin/bash' }
end

describe shadow.where(user: 'rsaxvc') do
  its('passwords.uniq') { should include 'totally_legit_password_hash' }
end

describe file('/home/rsaxvc/.ssh/authorized_keys') do
  its('content') { should match 'richards_ssh_key' }
end
