# Make sure dotfiles exist
describe file '/home/nick/.zshrc' do
  it { should exist }
end

# Check that vim has been bootstrapped by gruvbox's existence. This might have
# to change if Nick gets rid of gruvbox.
describe directory '/home/nick/.vim/plugged/gruvbox' do
  it { should exist }
end
