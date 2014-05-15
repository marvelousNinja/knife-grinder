require 'spec_helper'

describe Chef::Knife::Grinder do
  describe '#class' do
    it 'should derive from Chef::Knife' do
      subject.class.should < Chef::Knife
    end
  end

  context '#run' do
    it 'should be defined' do
      subject.should respond_to(:run)
    end

    it 'does not take any parameters' do
      expect { subject.run(Object.new) }.to raise_error
    end

    it 'should use Chef::Apply' do
      Chef::Application::Apply.any_instance.should_receive(:run)
      subject.run
    end
  end
end