# frozen_string_literal: true

class Api::V1::AccountHistoryController < ApplicationController
  before_action :authenticate

  def index
    actions = Api::V1::Services::UserHistoryIndexService.new.call(current_user, params[:id])
    render json: Api::V1::Serializers::AccountHistorySerializer.new(actions).serializable_hash
  end
end
