# frozen_string_literal: true

json.extract! user, :first_name, :last_name, :email, :account_type, :id
json.confirmed user.confirmed?