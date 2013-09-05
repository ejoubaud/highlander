module Services
  class Github < ActiveRecord::Base

    self.table_name = 'envato_services'

    include Service

    validates :username, presence: true, uniqueness: true

    def self.with_email email
      where("'#{email}' = ANY (emails)").first
    end

  end
end
