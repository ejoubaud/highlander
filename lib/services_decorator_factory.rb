class ServicesDecoratorFactory

  def self.setup_for user, service_name
    if user
      service = user.service_for(service_name)
      clazz = decorator_class(service_name)
      return clazz.new(service) if service
    end
    Services::NullDecorator.new
  end

  def self.decorator_class service_name
    "Services::#{ service_name.to_s.camelize }Decorator".constantize
  end
end
