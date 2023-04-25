class ApplicationController < ActionController::API
  append_view_path(Rails.root.glob('packages/*/app/views'))

  include Pagy::Backend
  include Authorization
  include ActionController::Cookies
  include ActionController::Helpers

  rescue_from Pundit::NotAuthorizedError, with: :permission_denied

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  before_action do
    ActiveStorage::Current.url_options = Rails.application.config.x.app_host
  end

  def current_user
    return if rodauth.rails_account.nil?

    Api::V1::User.find(rodauth.rails_account.user.id)
  end

  helper_method :current_user # skip if inheriting from ActionController::API

  def authenticate
    rodauth.require_account # redirect to login page if not authenticated
  end

  def alive
    render json: { success: 'i am alive!' }
  end

  private

  def user_not_authorized(error)
    render json: { error: "not authorized: #{error}" }, status: :unauthorized
  end

  def permission_denied
    render json: { error: 'permission denied' }, status: :forbidden
  end

  def not_found
    render json: { error: 'not found' }, status: :not_found
  end
end