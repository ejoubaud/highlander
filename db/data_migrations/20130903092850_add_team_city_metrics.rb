module DataMigration
  module MigrationFiles
    class AddTeamCityMetrics < Base

      def up
        Metric.create!(name: 'team_city_build_complete', description: 'Build Complete')
        Badge.create!(name: '1_green_build', tag: 'Well done, sir', description: 'First Green Build')
        Badge.create!(name: '100_green_builds', tag: 'Green goblin centurion', description: '100 Green Builds')
        Badge.create!(name: '250_green_builds', tag: 'Green goblin class act', description: '250 Green Builds')
        Badge.create!(name: '500_green_builds', tag: 'Green goblin beast', description: '500 Green Builds')
        Badge.create!(name: '1000_green_builds', tag: 'Green goblin GOD', description: '1000 Green Builds')
      end

      def down
        Metric.find_by_name('team_city_build_complete').destroy
        Badge.where(name: "1_green_build").destroy
        Badge.where(name: "100_green_builds").destroy
        Badge.where(name: "250_green_builds").destroy
        Badge.where(name: "500_green_builds").destroy
        Badge.where(name: "1000_green_builds").destroy
      end
    end
  end
end
