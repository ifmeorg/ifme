require "spec_helper"

describe Chromedriver::Helper do
  let(:helper) { Chromedriver::Helper.new }

  describe "#binary_path" do
    context "on a linux platform" do
      before { allow(helper).to receive(:platform) { "linux32" } }
      it { expect(helper.binary_path).to match(/chromedriver$/) }
    end

    context "on a windows platform" do
      before { allow(helper).to receive(:platform) { "win" } }
      it { expect(helper.binary_path).to match(/chromedriver\.exe$/) }
    end
  end

  describe '#platform' do
    os_cpu_matrix = [
      { 'host_os' => 'darwin','host_cpu' => 'irrelevant', 'expected_platform' => 'mac' },
      { 'host_os' => 'linux', 'host_cpu' => 'amd64',      'expected_platform' => 'linux64' },
      { 'host_os' => 'linux', 'host_cpu' => 'irrelevant', 'expected_platform' => 'linux32' },
      { 'host_os' => 'linux', 'host_cpu' => 'x86_64',     'expected_platform' => 'linux64' },
      { 'host_os' => 'mingw', 'host_cpu' => 'irrelevant', 'expected_platform' => 'win' },
      { 'host_os' => 'mswin', 'host_cpu' => 'irrelevant', 'expected_platform' => 'win' }
    ]

    os_cpu_matrix.each do |config|
      expected_platform = config['expected_platform']
      host_cpu          = config['host_cpu']
      host_os           = config['host_os']

      context "given host OS #{host_os} and host CPU #{host_cpu}" do
        before do
          RbConfig.send(:remove_const, :CONFIG)
          RbConfig::CONFIG = { 'host_os' => host_os, 'host_cpu' => host_cpu }
        end

        it "returns #{expected_platform}" do
          expect(helper.platform).to eq(expected_platform)
        end
      end
    end

    context 'given an unknown host OS' do
      before do
        RbConfig.send(:remove_const, :CONFIG)
        RbConfig::CONFIG = { 'host_os' => 'freebsd', 'host_cpu' => 'irrelevant' }
      end

      it 'raises an exception' do
        expect { helper.platform }.to raise_error("Unsupported host OS 'freebsd'")
      end
    end
  end
end
