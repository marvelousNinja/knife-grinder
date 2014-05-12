require 'spec_helper'

describe Chef::Provider::Machine do
  context 'ancestry' do
    it 'should include Chef::Provider base class' do
      described_class.should < Chef::Provider
    end
  end
end