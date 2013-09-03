module DataMigration
  module MigrationFiles
    class AddTeamCityMetrics < Base

      def up
        Metric.create!(name: 'team_city_build_complete', description: 'Build Complete')
      end

      def down
        Metric.find_by_name('team_city_build_complete').destroy
      end
    end
  end
end
