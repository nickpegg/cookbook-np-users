# Cinc should converge successfully, but also the ... directory shouldn't be
# created if we have no dotfiles to manage.
describe file('/home/nick/...') do
  it { is_expected.to_not exist }
end
