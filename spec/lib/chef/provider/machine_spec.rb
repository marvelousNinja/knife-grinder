require 'spec_helper'

describe Chef::Provider::Machine do
  let(:resource) do
    double(:name  => 'some_resource',
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
      Chef::Resource::Machine.stub(:new).and_return(new_resource)
    end

    let(:current_resource) { resource }
    let(:new_resource) { resource }

    it 'should be defined' do
      subject.should respond_to(:load_current_resource)
    end

    it 'does not take any parameters' do
      expect { subject.load_current_resource(Object.new) }.to raise_error
    end

    it 'should instantiate Chef::Resource::Machine' do
      Chef::Resource::Machine.should_receive(:new).with(new_resource.name).exactly(1).times
      subject.load_current_resource
    end

    it 'should call #type with arguments on a current resource' do
      current_resource.should_receive(:type).with(new_resource.type)
      subject.load_current_resource
    end

    it 'should call #image with arguments on a current resource' do
      current_resource.should_receive(:image).with(new_resource.image)
      subject.load_current_resource
    end

    it 'should call #type on a new resource' do
      new_resource.should_receive(:type).with(no_args)
      subject.load_current_resource
    end

    it 'should call #image on a new resource' do
      new_resource.should_receive(:image).with(no_args)
      subject.load_current_resource
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

    it 'should create a server on ec2' do
      Chef::Knife::Ec2ServerCreate.any_instance.should_receive(:run)
      subject.action_create
    end
  end

end