require 'spec_helper'

describe 'np-users::dotfiles' do
  shared_examples 'a nick file' do
    it { is_expected.to be_owned_by 'nick' }
    it { is_expected.to be_grouped_into 'nick' }

    it { is_expected.to be_readable.by_user 'nick' }
    it { is_expected.to be_writable.by_user 'nick' }
  end

  describe file('/home/nick/...') do
    it_behaves_like 'a nick file'
    it { is_expected.to be_directory }
  end

  describe file('/home/nick/.../conf') do
    it_behaves_like 'a nick file'
    it { is_expected.to be_file }
  end
end
