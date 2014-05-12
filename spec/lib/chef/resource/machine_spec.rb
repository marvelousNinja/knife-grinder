require 'spec_helper'

describe Chef::Resource::Machine do
  context 'ancestry' do
    it 'should include Knife base class' do
      described_class.should < Chef::Resource
    end

    it 'should call #super during initialization' do
      subject
    end
  end

  context '#resource_name' do
    it { should respond_to(:resource_name) }
    its(:resource_name) { should eq :machine }
  end

  context '#action' do
    it { should respond_to(:action) }
    its(:action) { should eq :create }
  end

  context '#allowed_actions' do
    it { should respond_to(:allowed_actions) }
    its(:allowed_actions) { should eq [:create] }
  end

  context '#provider' do
    it { should respond_to(:provider) }
    its(:provider) { should be_nil }
  end
end