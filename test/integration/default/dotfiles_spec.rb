require 'yaml'

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
  (0..2).each do |i|
    its(['dots', i, 'repo']) { should eq 'https://github.com/nickpegg/dotfiles' }
  end

  its(['dots', 0, 'branch']) { should eq 'master' }
  its(['dots', 0, 'path']) { should eq 'master' }

  its(['dots', 1, 'branch']) { should eq 'polo' }

  its(['dots', 2, 'branch']) { should be_nil }
end
