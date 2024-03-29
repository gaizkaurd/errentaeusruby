class Api::V1::Serializers::OrganizationSerializer
  include JSONAPI::Serializer

  set_type :organization
  set_id :id
  attributes :name, :description, :website, :email, :phone, :prices, :created_at, :price_range
  attributes :latitude, :longitude, :city, :province, :country, :street, :postal_code, :open_close_hours

  attribute :status
  attribute :open, &:open?
  attribute :near_close, &:near_close?
  attribute :logo_url, proc { |rec| rec.logo.url }, if: proc { |_, params| !params.fetch(:logo, nil).nil? }

  attribute :nearest_open_time, if: proc { |rec| !rec.open? }

  attribute :visible

  attributes :subscription_id,
             :settings,
             :google_place_id,
             :google_place_verified,
             :google_place_details,
             if: proc { |_record, params|
                   params[:manage].present? && params[:manage] == true
                 }

  attribute :skill_list, if: proc { |_, params| !params.fetch(:skills, nil).nil? }
  attribute :company_target_list, if: proc { |_, params| !params.fetch(:targets, nil).nil? }
  attribute :service_list, if: proc { |_, params| !params.fetch(:services, nil).nil? }

  attribute :google_place_details, if: proc { |rec| rec.google_place_id.present? && rec.google_place_verified }

  attributes :ratings do |object|
    {
      average: object.avg_rating,
      one_star_count: object.one_star_count,
      two_star_count: object.two_star_count,
      three_star_count: object.three_star_count,
      four_star_count: object.four_star_count,
      five_star_count: object.five_star_count
    }
  end
end
