class Api::V1::AccountHistory < ApplicationRecord
  belongs_to :user, class_name: 'Api::V1::UserRecord'

  enum :action, { log_in: 0, refresh_token: 1, logout: 2, block: 3, updated_user: 4 }
end
