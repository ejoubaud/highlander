class UserAccountDecorator < Draper::Decorator

  alias :user :source
  delegate_all

  attr_writer :twitter_account, :github_account, :instagram_account, :pager_duty_account, :envato_account

  def twitter_account
    @twitter_account ||= user.service_for(:twitter).try(:username)
  end

  def github_account
    @github_account ||= user.service_for(:github).try(:username)
  end

  def instagram_account
    @instagram_account ||= user.service_for(:instagram).try(:username)
  end

  def pager_duty_account
    @pager_duty_account ||= user.service_for(:pager_duty).try(:email)
  end

  def envato_account
    @envato_account ||= user.service_for(:envato).try(:username)
  end

  def attributes=(params)
    [:twitter_account, :github_account, :instagram_account, :pager_duty_account, :envato_account].each do |service_name|
      self.send("#{service_name}=", params.delete(service_name))
    end

    source.attributes = params
  end

  def save!
    transaction do
      source.save!
      set_service(:twitter, @twitter_account)
      set_service(:github, @github_account)
      set_service(:instagram, @instagram_account)
      set_service(:pager_duty, @pager_duty_account)
      set_service(:envato, @envato_account)
    end
  end

  def set_service(name, value)
    if value.present?
      if service = source.service_for(name)
        update_service(service, value)
      else
        add_service(name, value)
      end
    else
      remove_service(name)
    end
  end

  private

  def add_service service_name, value
    instance = "Services::#{service_name.to_s.camelize}".constantize.new
    update_service(instance, value)
    UserService.create!(service: instance, user: source)
  end

  def remove_service service_name
    source.service_for(service_name).try(:destroy)
  end

  def update_service service, value
    set_service_value(service, value)
    service.save!
  end

  def set_service_value service, value
    if service.respond_to?(:username)
      service.username = value
    else
      service.email = value
    end
  end

  # FIXME - Mixin
  class << self

    def model_name
      User.model_name
    end

  end

end
