require 'spec_helper'

describe Chef::Knife::Grinder do
  context 'ancestry' do
    it 'should include Knife base class' do
      described_class.should < Chef::Knife
    end
  end

  context '#run' do
    it 'should be defined' do
      subject.should respond_to(:run)
    end

    it 'should fail if there are any parameters' do
      expect { subject.run(Object.new) }.to raise_error(ArgumentError)
    end
  end
end