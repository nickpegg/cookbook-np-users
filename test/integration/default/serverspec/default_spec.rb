require 'spec_helper'

describe 'np-users::default' do
  # Check stuff that should have been done by user::data_bag
  describe user('nick') do
    it { is_expected.to exist }
    it { is_expected.to belong_to_group 'nick' }
    it { is_expected.to belong_to_group 'sudo' }
    it { is_expected.to have_login_shell '/usr/bin/zsh' }
    it { is_expected.to have_authorized_key 'nicks_ssh_key' }
    its(:encrypted_password) { is_expected.to match(/totally_legit_password_hash/) }
  end

  describe user('rsaxvc') do
    it { is_expected.to exist }
    it { is_expected.to belong_to_group 'rsaxvc' }
    it { is_expected.to_not belong_to_group 'sudo' }
    it { is_expected.to have_login_shell '/bin/bash' }
    it { is_expected.to have_authorized_key 'richards_ssh_key' }
    its(:encrypted_password) { should match(/totally_legit_password_hash/) }
  end
end
