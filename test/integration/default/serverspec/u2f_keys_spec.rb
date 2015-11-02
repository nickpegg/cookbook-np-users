require 'spec_helper'

describe 'np-users::u2f_keys' do
  ['/home/nick/.config', '/home/nick/.config/Yubico'].each do |dir|
    describe file(dir) do
      it { is_expected.to be_directory }
      it { is_expected.to be_readable.by 'owner' }
      it { is_expected.to be_writable.by 'owner' }
    end
  end

  describe file('/home/nick/.config/Yubico/u2f_keys') do
    it { is_expected.to exist }
    it { is_expected.to be_file }
    its(:content) { is_expected.to eq 'nick:some_yubikey' }
  end
end
