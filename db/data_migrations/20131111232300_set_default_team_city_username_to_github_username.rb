module DataMigration
  module MigrationFiles
    class SetDefaultTeamCityUsernameToGithubUsername < Base
      def up
        User.all.each do |user|
          if user.service_for(:github) && !user.service_for(:team_city)
            UserAccountDecorator.new(user).set_service(:team_city, user.service_for(:github).username)
          end
        end
      end

      def down
        # reversing this would kill existing good data along with the bad
      end
    end
  end
end