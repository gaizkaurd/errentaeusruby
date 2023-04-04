class Api::V1::OrganizationManage::BaseController < ApplicationController
  before_action :set_organization
  before_action :authenticate

  private

  def set_organization
    @organization = Api::V1::Organization.find(params[:organization_manage_id] || params[:id])

    raise Pundit::NotAuthorizedError unless @organization.user_is_admin?(current_user.id)
  end
end
