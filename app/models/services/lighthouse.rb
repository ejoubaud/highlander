module Services
  class Lighthouse < ActiveRecord::Base

    self.table_name = 'lighthouse_services'

    include Service

    validates :username, presence: true, uniqueness: true

  end
end
