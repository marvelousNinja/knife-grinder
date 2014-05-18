require 'spec_helper'

describe Chef::Provider::Machine do
  let(:resource) do
    double(:name  => 'my_lovely_node',
           :type  => 't1.micro',
           :image => 'ubuntu14.04')
  end
  
  subject do
    described_class.new(resource, nil)
  end

  describe '#class' do
    it 'should derive from Chef::Provider' do
      subject.class.should < Chef::Provider
    end
  end

  describe '#load_current_resource' do
    before(:each) do
      subject.stub(:new_resource).and_return(resource)
    end

    it 'should be defined' do
      subject.should respond_to(:load_current_resource)
    end

    it 'should rely on new_resource' do
      subject.should_receive(:new_resource)
      subject.load_current_resource
    end

    it 'should return new resource' do
      subject.load_current_resource.should eq resource
    end
  end

  describe '#action_create' do
    before(:each) do
      subject.stub(:new_resource) { resource }
      subject.load_current_resource
    end
    
    it 'should be defined' do
      subject.should respond_to(:action_create)
    end

    it 'does not take any parameters' do
      expect { subject.action_create(Object.new) }.to raise_error
    end

    it 'should rely on run_command with appropriate argument' do
      subject.should_receive(:run_command).with(Chef::Knife::Ec2ServerCreate)
      subject.action_create
    end
  end

  describe '#action_delete' do
    before(:each) do
      subject.stub(:new_resource) { resource }
      subject.load_current_resource
    end
    
    it 'should be defined' do
      subject.should respond_to(:action_delete)
    end

    it 'does not take any parameters' do
      expect { subject.action_delete(Object.new) }.to raise_error
    end

    it 'should rely on run_command with appropriate argument' do
      subject.should_receive(:run_command).with(Chef::Knife::Ec2ServerDelete)
      subject.action_delete
    end
  end
end