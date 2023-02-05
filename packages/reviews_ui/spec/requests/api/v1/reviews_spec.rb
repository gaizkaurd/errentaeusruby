require 'rails_helper'

RSpec.describe Api::V1::ReviewsController do
  let(:user) { create(:user) }
  let(:organization) { create(:organization) }
  let(:review_attributes) { attributes_for(:review, organization_id: organization.id, user_id: user.id) }

  let(:invalid_attributes) do
    {
      review: {
        comment: '',
        rating: 5,
        organization_id: create(:organization).id
      }
    }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Api::V1::Repositories::ReviewRepository.add(review_attributes, raise_error: true)
      get api_v1_reviews_url(organization_id: organization.id)
      expect(response).to be_successful
      expect(JSON.parse(response.body)['data'].size).to eq(1)
    end
  end

  context 'with no signed user' do
    describe 'POST /create' do
      it 'does not create a new Review' do
        expect do
          post api_v1_reviews_url, params: { review: review_attributes }
        end.not_to change(Api::V1::Repositories::ReviewRepository, :count)
      end

      it 'renders a JSON response with errors for the new review' do
        post api_v1_reviews_url, params: { review: review_attributes }
        expect(response).to have_http_status(:unauthorized)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end
  end

  context 'with signed in user' do
    before do
      sign_in user
    end

    describe 'POST /create' do
      context 'with valid parameters' do
        it 'creates a new Review' do
          expect do
            post api_v1_reviews_url, params: { review: review_attributes }
          end.to change(Api::V1::Repositories::ReviewRepository, :count).by(1)
        end

        it 'renders a JSON response with the new review' do
          post api_v1_reviews_url, params: { review: review_attributes }
          expect(response).to have_http_status(:created)
          expect(response.content_type).to match(a_string_including('application/json'))
        end
      end

      context 'with invalid parameters' do
        it 'does not create a new Review' do
          expect do
            post api_v1_reviews_url, params: invalid_attributes
          end.not_to change(Api::V1::Repositories::ReviewRepository, :count)
        end

        it 'renders a JSON response with errors for the new review' do
          post api_v1_reviews_url, params: invalid_attributes
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to match(a_string_including('application/json'))
        end
      end
    end
  end
end