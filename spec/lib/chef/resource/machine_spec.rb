require 'spec_helper'

describe Chef::Resource::Machine do 
  subject do
    described_class.new('some string') 
  end

  describe '#class' do
    it 'should derive from Chef::Resource' do
      subject.class < Chef::Resource
    end
  end

  describe '#machine_types' do
    it 'should be defined' do
      subject.should respond_to(:machine_types)
    end

    it 'should be equal to ["t1.micro"]' do
      subject.machine_types.should eq ['t1.micro']
    end
  end

  describe '#resource_name' do
    it 'should be defined' do
      subject.should respond_to(:resource_name)
    end

    it 'should default to :machine' do
      subject.resource_name.should eq :machine
    end
  end

  describe '#action' do
    it 'should be defined' do
      subject.should respond_to(:action)
    end
    
    it 'should default to :create' do
      subject.action.should eq :create
    end
  end
  
  describe '#allowed_actions' do
    it 'should be defined' do
      subject.should respond_to(:allowed_actions)
    end

    it 'should default to [:create]' do
      subject.allowed_actions.should eq [:create]
    end
  end

  describe '#provider' do
    it 'should be defined' do
      subject.should respond_to(:provider)
    end

    it 'should default to Chef::Provider::Machine' do
      subject.provider.should eq Chef::Provider::Machine
    end
  end

  describe '#type' do
    it 'should be defined' do
      subject.should respond_to(:type)
    end

    it 'should be a required string parameter, included in #machine_types' do
      subject.should_receive(:set_or_return).with(:type, nil, {
        :required => true,
        :kind_of => String,
        :equal_to => subject.machine_types,
        :default => subject.machine_types.first })
      subject.type
    end
  end

  describe '#image' do
    it 'should be defined' do
      subject.should respond_to(:image)
    end

    it 'should be a non-required string parameter' do
      subject.should_receive(:set_or_return).with(:image, nil, {
        :required => false,
        :kind_of => String })
      subject.image
    end
  end
end