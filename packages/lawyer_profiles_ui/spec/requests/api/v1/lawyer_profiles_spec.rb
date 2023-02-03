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

RSpec.describe '/api/v1/lawyer_profiles' do
  let(:lawyer) { create(:lawyer) }
  let(:user) { create(:user) }
  let(:organization) { create(:organization) }

  let(:valid_attributes) do
    { organization_id: organization.id }
  end

  let(:invalid_attributes) do
    { organization_id: 3, org_status: 'accepted' }
  end

  context 'when logged in organization owner' do
    before do
      sign_in(organization.owner)
    end

    describe 'GET /index' do
      it 'renders a successful response' do
        Api::V1::Repositories::LawyerProfileRepository.add({ user_id: lawyer.id, organization_id: organization.id })
        authorized_get api_v1_lawyer_profiles_url(organization_id: organization.id), as: :json
        expect(response).to be_successful
        expect(JSON.parse(response.body)['data'].first['relationships']['user']['data']['id']).to eq(lawyer.id)
      end
    end

    describe 'GET /show' do
      it 'renders a successful response' do
        lawprof = Api::V1::Repositories::LawyerProfileRepository.add({ user_id: lawyer.id, organization_id: organization.id })
        authorized_get api_v1_lawyer_profile_url(lawprof.id), as: :json
        expect(response).to be_successful
        expect(JSON.parse(response.body)['data']['relationships']['user']['data']['id']).to eq(lawyer.id)
      end
    end

    describe 'POST /create' do
      it 'does not allow to create lawyer_profile' do
        expect do
          authorized_post api_v1_lawyer_profiles_url, params: { lawyer_profile: valid_attributes }, as: :json
        end.not_to change(Api::V1::Repositories::LawyerProfileRepository, :count)
      end
    end

    describe 'PATCH /update' do
      it 'can update organization lawyers_profiles' do
        lawprof = Api::V1::Repositories::LawyerProfileRepository.add({ user_id: lawyer.id, organization_id: organization.id })
        expect do
          authorized_patch api_v1_lawyer_profile_url(lawprof.id), params: { lawyer_profile: { org_status: 'accepted' } }, as: :json
        end.not_to change(Api::V1::Repositories::LawyerProfileRepository, :count)
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['data']['attributes']['org_status']).to eq('accepted')
      end

      it 'cannot update other organization lawyers_profiles' do
        other_organization = create(:organization)
        lawprof = Api::V1::Repositories::LawyerProfileRepository.add({ user_id: lawyer.id, organization_id: other_organization.id })
        expect do
          authorized_patch api_v1_lawyer_profile_url(lawprof.id), params: { lawyer_profile: { org_status: 'accepted' } }, as: :json
        end.not_to change(Api::V1::Repositories::LawyerProfileRepository, :count)
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  context 'when logged in lawyer and existing lawyer_profile' do
    let(:lawyer_profile) { create(:lawyer_profile, user_id: lawyer.id) }

    before do
      sign_in(lawyer)
    end

    describe 'SHOW /:id' do
      it 'renders a successful response' do
        authorized_get api_v1_lawyer_profile_url(lawyer_profile.id), as: :json
        expect(response).to be_successful
        expect(JSON.parse(response.body)['data']['relationships']['user']['data']['id']).to eq(lawyer.id)
      end
    end

    describe 'GET /me' do
      it 'renders a successful response' do
        Api::V1::Repositories::LawyerProfileRepository.add({ user_id: lawyer.id, organization_id: organization.id })
        authorized_get me_api_v1_lawyer_profiles_url, as: :json
        expect(response).to be_successful
        expect(JSON.parse(response.body)['data']['relationships']['user']['data']['id']).to eq(lawyer.id)
      end
    end
  end

  context 'when logged in lawyer and non-existing lawyer_profile' do
    before do
      sign_in(lawyer)
    end

    describe 'CREATE' do
      context 'with valid parameters' do
        it 'creates a new LawyerProfile' do
          expect do
            authorized_post api_v1_lawyer_profiles_url, params: { lawyer_profile: valid_attributes }, as: :json
          end.to change(Api::V1::Repositories::LawyerProfileRepository, :count).by(1)
        end

        it 'renders a JSON response with the new lawyer_profile' do
          authorized_post api_v1_lawyer_profiles_url, params: { lawyer_profile: valid_attributes }, as: :json
          expect(response).to have_http_status(:created)
          expect(response.content_type).to match(a_string_including('application/json'))
        end

        it 'creates a new LawyerProfile with the correct attributes' do
          authorized_post api_v1_lawyer_profiles_url, params: { lawyer_profile: valid_attributes }, as: :json
          expect(response).to have_http_status(:created)
          expect { Api::V1::Repositories::LawyerProfileRepository.find_by!(organization_id: organization.id) }
            .not_to raise_error
        end
      end

      context 'with invalid parameters' do
        it 'does not create a new LawyerProfile' do
          expect do
            authorized_post api_v1_lawyer_profiles_url, params: { lawyer_profile: invalid_attributes }, as: :json
          end.not_to change(Api::V1::Repositories::LawyerProfileRepository, :count)
        end

        it 'renders a JSON response with errors for the new lawyer_profile' do
          authorized_post api_v1_lawyer_profiles_url, params: { lawyer_profile: invalid_attributes }, as: :json
          expect(response).to have_http_status(:unprocessable_entity)
          expect(JSON.parse(response.body)['organization']).to be_present
          expect(response.content_type).to match(a_string_including('application/json'))
        end
      end
    end
  end

  context 'when logged in user' do
    before do
      sign_in(user)
    end

    describe 'CREATE' do
      context 'with valid parameters' do
        it 'does not create a new LawyerProfile' do
          expect do
            authorized_post api_v1_lawyer_profiles_url, params: { lawyer_profile: valid_attributes }, as: :json
          end.not_to change(Api::V1::Repositories::LawyerProfileRepository, :count)
        end

        it 'renders a JSON response with errors for the new lawyer_profile' do
          authorized_post api_v1_lawyer_profiles_url, params: { lawyer_profile: valid_attributes }, as: :json
          expect(response).to have_http_status(:forbidden)
          expect(response.content_type).to match(a_string_including('application/json'))
        end
      end
    end

    describe 'UPDATE /:id' do
      let(:lawyer_profile) { create(:lawyer_profile, user_id: lawyer.id) }

      context 'with valid parameters' do
        it 'does not update the requested lawyer_profile' do
          authorized_patch api_v1_lawyer_profile_url(lawyer_profile.id), params: { lawyer_profile: { lawyer_status: 'on_duty' } }, as: :json
          lawyer_profile.reload
          expect(lawyer_profile.lawyer_status).not_to eq('on_duty')
        end

        it 'renders a JSON response with errors for the lawyer_profile' do
          authorized_patch api_v1_lawyer_profile_url(lawyer_profile.id), params: { lawyer_profile: { lawyer_status: 'off_duty' } }, as: :json
          expect(response).to have_http_status(:forbidden)
          expect(response.content_type).to match(a_string_including('application/json'))
        end
      end
    end

    describe 'SHOW /:id' do
      let(:lawyer_profile) { create(:lawyer_profile, user_id: lawyer.id) }

      it 'renders a successful response' do
        authorized_get api_v1_lawyer_profile_url(lawyer_profile.id), as: :json
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'ME /me' do
      let(:lawyer_profile) { create(:lawyer_profile, user_id: lawyer.id) }

      it 'renders a forbidden response' do
        authorized_get me_api_v1_lawyer_profiles_url, as: :json
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
