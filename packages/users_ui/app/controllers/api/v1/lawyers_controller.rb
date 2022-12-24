# frozen_string_literal: true

module Api
  module V1
    class LawyersController < ApiBaseController
      before_action :authorize_access_request!
      before_action :set_lawyer

      def show
        render partial: 'lawyers/lawyer'
      end

      private

      def set_lawyer
        @lawyer = Api::V1::Services::FindLawyerService.new.call(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def lawyer_params
        params.require(:lawyer).permit(:id)
      end
    end
  end
end