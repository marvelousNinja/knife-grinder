require 'spec_helper'

describe Chef::Provider::Machine do
  let(:resource) { stub(:name => 'some_resource', :free => true) }
  subject { described_class.new(resource, nil) }

  context 'ancestry' do
    it 'should include Chef::Provider base class' do
      described_class.should < Chef::Provider
    end
  end

  context '#load_current_resource' do
    before(:each) do
      Chef::Resource::Machine.stub(:new).and_return(new_resource)
    end

    let(:current_resource) { resource }
    let(:new_resource) { resource }

    it { should respond_to(:load_current_resource) }

    it 'does not take any parameters' do
      expect { subject.load_current_resource(Object.new) }.to raise_error(ArgumentError)
    end

    it 'should instantiate Chef::Resource::Machine' do
      Chef::Resource::Machine.should_receive(:new).with(new_resource.name).exactly(1).times
      subject.load_current_resource
    end

    it 'should call #free with arguments on a current resource' do
      current_resource.should_receive(:free).with(new_resource.free)
      subject.load_current_resource
    end

    it 'should call #free on a new resource' do
      new_resource.should_receive(:free).with(no_args)
      subject.load_current_resource
    end
  end

  context '#action_create' do
    it { should respond_to(:action_create) }

    it 'does not take any parameters' do
      expect { subject.action_create(Object.new) }.to raise_error(ArgumentError)
    end

    it 'should print a message' do
      subject.should_receive(:puts).with('some crazy code here')
      subject.action_create
    end
  end
end