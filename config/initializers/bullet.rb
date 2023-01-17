if Rails.env.development? || Rails.env.test?
  Bullet.add_safelist type: :unused_eager_loading, class_name: 'Api::V1::UserRecord', association: :account
  Bullet.add_safelist type: :unused_eager_loading, class_name: 'Api::V1::TaxIncome', association: :appointment
end
