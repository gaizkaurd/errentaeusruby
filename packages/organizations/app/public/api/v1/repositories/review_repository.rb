class Api::V1::Repositories::ReviewRepository < Repositories::RepositoryBase
  FILTER_KEYS = %i[rating].freeze
  public_constant :FILTER_KEYS

  def self.map_record(record)
    super(record) do
      Api::V1::Review.new(record.attributes.symbolize_keys!.merge({ first_name: record.user&.first_name, last_name: record.user&.last_name }))
    end
  end

  def self.query_base
    Api::V1::ReviewRecord.includes(:user)
  end
end