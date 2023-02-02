require 'rails_helper'

RSpec.describe 'AccountHistory' do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }
  let(:account_history) { create(:account_history, account_id: user.account_id) }

  context 'when logged in admin' do
    before do
      sign_in(admin)
    end

    describe 'index /:id/history' do
      it 'renders a successful response' do
        authorized_get history_api_v1_account_url(user.id), as: :json
        expect(response).to be_successful
      end
    end
  end

  context 'when logged in user' do
    before do
      sign_in(user)
    end

    describe 'index /:id/history' do
      it 'renders a successful response' do
        authorized_get history_api_v1_account_url(user.id), as: :json
        expect(response).to be_successful
      end

      it 'renders error when user is not the same' do
        authorized_get history_api_v1_account_url(admin.id), as: :json
        expect(response).to be_forbidden
      end
    end
  end

  context 'when not logged in' do
    describe 'index /:id/history' do
      it 'renders error' do
        authorized_get history_api_v1_account_url(user.id), as: :json
        expect(response).to be_unauthorized
      end
    end
  end
end
