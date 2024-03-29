class Api::V1::Calculator < ApplicationRecord
  include PrettyId
  self.id_prefix = 'calcr'

  belongs_to :calculation_topic, class_name: 'Api::V1::CalculationTopic'
  belongs_to :organization, class_name: 'Api::V1::Organization'

  has_many :calculations, class_name: 'Api::V1::Calculation', dependent: :destroy

  validates :calculator_status, inclusion: { in: %w[live training error disabled waiting_for_training] }

  delegate :name, to: :calculation_topic
  delegate :variable_data_types, to: :calculation_topic
  delegate :prediction_attributes, to: :calculation_topic
  delegate :attributes_training, to: :calculation_topic
  delegate :variable_types, to: :calculation_topic
  delegate :sanitize_variable, to: :calculation_topic
  delegate :exposed_variables_formatted, to: :calculation_topic
  delegate :questions, to: :calculation_topic
  delegate :description, to: :calculation_topic
  delegate :estimated_time, to: :calculation_topic
  delegate :colors, to: :calculation_topic
  delegate :predict, to: :predictor

  def train
    return unless eligible_to_train?

    self.calculator_status = 'waiting_for_training'
    save!
    CalculatorPubSub.publish('calculator.train', { calculator_id: id })
  end

  def predictor
    # rubocop:disable Security/MarshalLoad
    @predictor ||= Marshal.load(marshalled_predictor)
    # rubocop:enable Security/MarshalLoad
  end

  def predictor=(predictor)
    self.marshalled_predictor = Marshal.dump(predictor)
  end

  def eligible_to_train?
    last_trained_at.nil? || last_trained_at < 5.minutes.ago
  end
end
