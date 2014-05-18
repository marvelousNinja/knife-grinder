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
      subject.stub(:new_resource) { resource }
    end

    it 'should be defined' do
      subject.should respond_to(:load_current_resource)
    end

    it 'should rely new resource' do
      subject.should_receive(:new_resource).and_return(:new_resource)
      subject.load_current_resource
    end

    it 'should return a new resource' do
      subject.load_current_resource.should eq subject.new_resource
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

    context 'when machine exists' do
      before(:each) do
        subject.stub(:machine_exists?) { true }
      end

      it 'should not call command' do
        subject.should_not_receive(:run_command).with(Chef::Knife::Ec2ServerCreate)
      end
    end

    context 'when machine does not exist' do
      before(:each) do
        subject.stub(:machine_exists?) { false }
      end

      it 'should converge infrastucture state' do
        subject.should_receive(:converge_by).with("Creating #{subject.current_resource}")
        subject.action_create
      end

      it 'should rely on appropriate command' do
        subject.stub(:converge_by).and_yield
        subject.should_receive(:run_command).with(Chef::Knife::Ec2ServerCreate)
        subject.action_create
      end
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
      expect { 
        subject.action_delete(Object.new) 
      }.to raise_error
    end

    context 'when machine does not exist' do
      before(:each) do
        subject.stub(:machine_exists?) { false }
      end

      it 'should not call command' do
        subject.should_not_receive(:run_command).with(Chef::Knife::Ec2ServerDelete)
      end
    end

    context 'when machine exists' do
      before(:each) do
        subject.stub(:machine_exists?) { true }
      end

      it 'should converge infrastucture state' do
        subject.should_receive(:converge_by).with("Deleting #{subject.current_resource}")
        subject.action_delete
      end

      it 'should rely on appropriate command' do
        subject.stub(:converge_by).and_yield
        subject.should_receive(:run_command).with(Chef::Knife::Ec2ServerDelete)
        subject.action_delete
      end
    end
  end
end