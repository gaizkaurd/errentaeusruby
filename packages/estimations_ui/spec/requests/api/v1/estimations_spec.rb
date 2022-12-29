require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/api/v1/estimations' do
  let(:user) { create(:user) }

  # This should return the minimal set of attributes required to create a valid
  # Api::V1::Estimation. As you add validations to Api::V1::Estimation, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    {
      first_name: 'Gaizka',
      first_time: false,
      home_changes: 0,
      rentals_mortgages: 0,
      professional_company_activity: false,
      real_state_trade: 0,
      with_couple: false,
      income_rent: 0,
      shares_trade: 0,
      outside_alava: false,
      token: SecureRandom.hex(10)
    }
  end

  let(:valid_attributes_for_estimate) do
    {
      first_name: 'Gaizka',
      first_time: false,
      home_changes: 0,
      rentals_mortgages: 0,
      professional_company_activity: false,
      real_state_trade: 0,
      with_couple: false,
      income_rent: 0,
      shares_trade: 0,
      outside_alava: false
    }
  end

  let(:invalid_attributes) do
    {
      first_name: 3,
      home_changes: 0,
      rentals_mortgages: 0,
      professional_company_activity: false,
      with_couple: false,
      income_rent: 0,
      id: 3,
      shares_trade: 0,
      outside_alava: false,
      price: 3
    }
  end

  describe 'GET /show' do
    before do
      sign_in(user)
    end

    it 'renders a successful response' do
      estimation = Api::V1::Estimation.create! valid_attributes
      authorized_get api_v1_estimation_path(estimation)
      expect(response).to be_successful
    end
  end

  describe 'POST /estimate' do
    context 'with valid parameters' do
      it 'generates valid JWT' do
        post estimate_api_v1_estimations_url, params: { estimation: valid_attributes_for_estimate }
        token = JSON.parse(response.body)['token']['data']
        expect { JWT.decode(token, Rails.application.config.x.estimation_sign_key, true, { algorithm: 'HS512' }) }
          .not_to raise_error
      end

      it 'parses correctly data in JWT' do
        post estimate_api_v1_estimations_url, params: { estimation: valid_attributes_for_estimate }
        token = JSON.parse(response.body)['token']['data']
        decoded_data = JWT.decode(token, Rails.application.config.x.estimation_sign_key, true, { algorithm: 'HS512' })
        expect(decoded_data[0]['data'].except('token').symbolize_keys!).to match(a_hash_including(valid_attributes_for_estimate))
      end
    end

    context 'with invalid parameters' do
      it 'returns errors' do
        post estimate_api_v1_estimations_url, params: { estimation: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'POST /estimation_from_jwt' do
    it 'generates and returns valid params' do
      post estimate_api_v1_estimations_url, params: { estimation: valid_attributes_for_estimate }
      token = JSON.parse(response.body)['token']['data']
      estimation = response.body
      post estimation_from_jwt_api_v1_estimations_url, params: { estimation_jwt: token }
      expect(response.body).to match(a_string_including(estimation))
    end
  end

  describe 'PATCH /update' do
    before do
      sign_in(user)
    end

    context 'with valid parameters' do
      let(:new_attributes) do
        { home_changes: 5 }
      end

      it 'updates the requested api_v1_estimation' do
        estimation = Api::V1::Estimation.create! valid_attributes
        authorized_patch api_v1_estimation_url(estimation), params: { estimation: new_attributes }
        estimation.reload
        expect(response).to have_http_status(:ok)
        expect(estimation.home_changes).to match(new_attributes[:home_changes])
      end
    end

    context 'with invalid parameters' do
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        estimation = Api::V1::Estimation.create! valid_attributes
        authorized_put api_v1_estimation_url(estimation), params: { estimation: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    before do
      sign_in(user)
    end

    it 'destroys the requested api_v1_estimation' do
      estimation = Api::V1::Estimation.create! valid_attributes
      expect do
        authorized_delete api_v1_estimation_url(estimation)
      end.to change(Api::V1::Estimation, :count).by(-1)
    end
  end
end
