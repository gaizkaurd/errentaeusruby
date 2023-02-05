require 'rails_helper'

describe Api::V1::Services::UserCreateService, type: :service do
  subject(:service) { described_class.new }

  let(:requesting_ip) { '0.0.0.0' }
  let(:valid_attributes) { attributes_for(:user) }
  let(:account) { create(:account) }

  describe '#call' do
    context 'with valid attributes' do
      it 'does persist user' do
        user = service.call(valid_attributes, requesting_ip)
        expect(user.persisted?).to be true
      end
    end

    context 'with valid user' do
      it 'does not persist user' do
        user = service.call({ first_name: 'gaizka', account_id: -1 }, requesting_ip, raise_error: false)
        expect(user.persisted?).to be false
      end

      it 'does return errors' do
        user = service.call({ first_name: 'asdasd', account_id: -1 }, requesting_ip, raise_error: false)
        expect(user.errors).to be_present
      end

      it 'does raise errors' do
        expect do
          service.call({ first_name: 'asdasd', account_id: -1 }, requesting_ip, raise_error: true)
        end.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end