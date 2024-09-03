describe user('nick') do
  it { should exist }
  its('groups') { should include 'nick' }
  its('groups') { should include 'sudo' }
  its('groups') { should_not include 'docker' }
  its('shell') { should eq '/usr/bin/fish' }
end

describe file('/usr/bin/fish') do
  it { should exist }
end

describe file('/home/nick/.ssh/authorized_keys') do
  it { should be_owned_by 'nick' }
  it { should be_writable.by('owner') }
  it { should_not be_writable.by('others') }
  its('content') { should match 'nick@polo' }
  its('content') { should match 'mr8= test key' }
end

# Make sure dotfiles exist
describe file '/home/nick/.config/fish/config.fish' do
  it { should exist }
end

# Check that vim has been bootstrapped by gruvbox's existence. This might have
# to change if Nick gets rid of gruvbox.
describe directory '/home/nick/.vim/plugged/gruvbox' do
  it { should exist }
end
