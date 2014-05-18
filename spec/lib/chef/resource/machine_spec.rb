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

    it 'should constist of :create and :delete' do
      subject.allowed_actions.should eq [:create, :delete]
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

  describe '#chef_node_name' do
    it 'should be defined' do
      subject.should respond_to(:chef_node_name)
    end

    it 'should be a string identity attribute' do
      subject.should_receive(:set_or_return).with(:chef_node_name, nil, {
        :required => true,
        :kind_of => String,
        :name_attribute => true })
      subject.chef_node_name
    end
  end

  describe '#infrastructure' do
    it 'should be defined' do
      subject.should respond_to(:infrastructure)
    end

    it 'should be a required string parameter' do
      subject.should_receive(:set_or_return).with(:infrastructure, nil, {
        :required => true,
        :kind_of => String
      })
      subject.infrastructure
    end
  end

  describe 'dynamic attribute' do
    before(:each) do
      subject.sample_attribute('sample_value')
    end

    it 'becomes defined after some value has been passed' do
      subject.should respond_to(:sample_attribute)
    end

    it 'relies on built-in attributes support' do
      subject.should_receive(:set_or_return).with(:sample_attribute, nil, {})
      subject.sample_attribute
    end

    it 'returns stored value if no args have been passed' do
      subject.sample_attribute('new_value')
      subject.sample_attribute.should eq 'new_value'
    end

    context 'if value hasnt been set before' do
      it 'cant load it' do
        expect {
          subject.non_existing_attribute
        }.to raise_error
      end

      it 'cant set it if there is there is more than one parameter' do
        expect {
          subject.non_existing_attribute('first', 'second')
        }.to raise_error
      end
    end
  end    
end