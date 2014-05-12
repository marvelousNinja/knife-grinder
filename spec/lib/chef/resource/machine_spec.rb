require 'spec_helper'

describe Chef::Resource::Machine do
  context 'ancestry' do
    it 'should include Chef::Resource base class' do
      described_class.should < Chef::Resource
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
    its(:provider) { should eq Chef::Provider::Machine }
  end

  context '#free' do
    it { should respond_to(:free) }
    its(:free) { should eq true }

    context 'with correct args' do
      let(:args) { [true, false, nil] }

      it 'should not fail' do
        expect {
          args.each { |arg| subject.free(arg) }
        }.not_to raise_error(Chef::Exceptions::ValidationFailed)
      end

      it 'should set value correctly' do
        stored_value = subject.free(true)
        stored_value.should eq true
      end

      it 'should return stored value if nil passed' do
        stored_value = subject.free(true)
        stored_value.should eq subject.free(nil)
      end

      it 'should act like getter with no parameters' do
        stored_value = subject.free(true)
        stored_value.should eq subject.free
      end
    end

    context 'with incorrect args' do
      context 'like random string' do
        it 'should fail with Chef::Exceptions::ValidationFailed' do
          expect { subject.free('random_string') }.to raise_error(Chef::Exceptions::ValidationFailed)
        end
      end

      context 'like 42' do
        it 'should fail with Chef::Exceptions::ValidationFailed' do
          expect { subject.free(42) }.to raise_error(Chef::Exceptions::ValidationFailed)
        end
      end
    end
  end
end