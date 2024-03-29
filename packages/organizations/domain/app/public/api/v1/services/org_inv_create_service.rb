class Api::V1::Services::OrgInvCreateService < ApplicationService
  def call(current_account, org_id, inv_params)
    org = Api::V1::Organization.find(org_id)

    raise Pundit::NotAuthorizedError unless org.user_is_admin?(current_account.id)

    Api::V1::OrganizationInvitation.create!(inv_params.merge!(organization_id: org_id)).tap do |inv|
      OrganizationPubSub.publish('organization.invitation_created', organization_inv_id: inv.id)
    end
  end
end
