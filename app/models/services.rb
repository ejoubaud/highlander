module Services

  def self.class_for service_name
    "Services::#{service_name.to_s.camelize}".constantize
  end

end
