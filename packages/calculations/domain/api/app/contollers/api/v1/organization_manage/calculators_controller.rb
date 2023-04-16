# frozen_string_literal: true

class Api::V1::OrganizationManage::CalculatorsController < Api::V1::OrganizationManage::BaseController
  before_action :authenticate

  def index
    calc = Api::V1::Calculators.where(organization: @organization)

    render json: Api::V1::Serializers::CalculatorSerializer.new(calc)
  end
end
