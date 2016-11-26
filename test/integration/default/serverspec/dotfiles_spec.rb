require 'yaml'
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

    it 'should have correct repos set up' do
      repos = YAML.load(File.read('/home/nick/.../conf'))['dots']
      expect(repos[0]['repo']).to eq 'https://github.com/nickpegg/dotfiles'
      expect(repos[0]['branch']).to eq 'polo'
      expect(repos[1]['repo']).to eq 'https://github.com/nickpegg/dotfiles'
      expect(repos[1]['branch']).to be_nil
    end
  end
end
