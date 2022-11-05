class AddCustomerIdToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :stripe_customer_id, :string, null: true
  end
end
