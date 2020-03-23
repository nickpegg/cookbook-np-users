describe file('/home/nick/...') do
  it { is_expected.to be_owned_by 'nick' }
  it { is_expected.to be_readable.by_user 'nick' }
  it { is_expected.to be_writable.by_user 'nick' }
  it { is_expected.to be_directory }
end

describe file('/home/nick/.../conf') do
  it { is_expected.to be_file }
  it { is_expected.to be_owned_by 'nick' }
  it { is_expected.to be_readable.by_user 'nick' }
  it { is_expected.to be_writable.by_user 'nick' }
end

describe yaml('/home/nick/.../conf') do
  its(['dots', 0, 'repo']) { should eq 'https://github.com/nickpegg/dotfiles' }
  its(['dots', 0, 'branch']) { should eq 'polo' }

  its(['dots', 1, 'repo']) { should eq 'https://github.com/nickpegg/dotfiles' }
  its(['dots', 1, 'branch']) { should be_nil }
end

# Check that vim has been bootstrapped by gruvbox's existence. This might have
# to change if Nick gets rid of gruvbox.
describe directory '/home/nick/.vim/bundle/gruvbox' do
  it { should exist }
end
