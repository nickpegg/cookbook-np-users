describe file('/home/nick/.oh-my-zsh') do
  it { is_expected.to be_directory }
  it { is_expected.to be_owned_by 'nick' }
end
