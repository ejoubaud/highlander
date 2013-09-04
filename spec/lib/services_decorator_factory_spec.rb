require 'spec_helper'

describe ServicesDecoratorFactory do

  describe '.setup_for' do

    let(:service) { double('service') }
    let(:decorator) { double('decorator') }
    let(:user) { double('user') }

    context 'existing service' do

      it 'instanciates the right service class' do
        user.should_receive(:service_for).with(:twitter).and_return(service)
        Services::TwitterDecorator.should_receive(:new).with(service).and_return(decorator)

        ServicesDecoratorFactory.setup_for(user, :twitter).should be decorator
      end

    end

    context 'no existing service' do

      it 'returns a null service' do
        user.should_receive(:service_for).and_return(nil)
        Services::NullDecorator.should_receive(:new).and_return(decorator)

        ServicesDecoratorFactory.setup_for(user, :twitter).should be decorator
      end

    end

  end

end
