class Clan < ActiveRecord::Base
  has_many :kinships
  has_many :users, through: :kinships
  has_many :bounties

  serialize :configuration_settings, Hash

  def kinship_for_user(user)
    if user.new_record?
      nil
    else
      kinships.where(user_id: user.id).first
    end
  end

  def get_integration_config(integration_class)
    configuration_settings[integration_class.to_s].try(:with_indifferent_access)
  end

  def set_integration_config(integration_class, config)
    hash = self.configuration_settings.dup

    if config.values.all?(&:blank?)
      hash.delete(integration_class.to_s)
    else
      hash[integration_class.to_s] = config
    end

    self.configuration_settings = hash
  end

  def host
    "#{slug}.#{SITE_ROOT}"
  end
end
