module Services
  class TeamCity < ActiveRecord::Base

    self.table_name = 'team_city_services'

    include Service

    validates :username, presence: true, uniqueness: true

  end
end