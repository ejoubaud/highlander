class Event < ActiveRecord::Base

  belongs_to :user
  belongs_to :kinship
  belongs_to :metric

  validate :value, numericality: true

  before_save :ensure_user_setup

  Metric::NAMES.each do |metric|
    scope metric.pluralize.to_sym, -> { joins(:metric).where("metrics.name = '#{metric}'") }
  end

  def self.with_key_and_value(key, value)
    where("data @> '#{key}=>\"#{value}\"'")
  end
  private

  def ensure_user_setup
    self.user ||= kinship.user
  end


end
