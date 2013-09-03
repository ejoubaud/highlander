class UserAccountDecorator < Draper::Decorator

  alias :user :source
  delegate_all

  attr_writer :twitter_account, :github_account, :instagram_account, :pager_duty_account

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

  def attributes=(value)
    [:twitter_account, :github_account, :instagram_account, :pager_duty_account].each do |blah|
      puts "Set #{blah} to #{value[blah]}"
      self.send("#{blah}=", value.delete(blah))
    end

    source.attributes = value
  end

  def save
    transaction do
      save!
      puts "sdfsfdfsd"
        update_service(:twitter, @twitter_account)
        update_service(:github, @github_account)
        update_service(:instagram, @instagram_account)
        update_service(:pager_duty, @pager_duty_account)
      # end
    end
  end

  private

  def update_service(name, value)
    puts "#{name} #{value}"
    if value.present?
      if service = source.service_for(name)
        if service.respond_to?(:username)
          service.username = value
        else
          service.email = value
        end
          
        service.save!        
      else
        instance = "Services::#{name.to_s.camelize}".constantize.new
        if instance.respond_to?(:username)
          instance.username = value
        else
          instance.email = value
        end

        instance.save!

        UserService.create!(service: instance, user: source)

        puts "Created!"
      end
    else
      source.service_for(name).destroy
    end
  end


  # FIXME - Mixin
  class << self

    def model_name
      User.model_name
    end

  end

end
