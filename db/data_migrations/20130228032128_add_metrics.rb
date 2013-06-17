module DataMigration
  module MigrationFiles
    class AddMetrics < Base

      def up
        Metric.create!(name: 'twitter_mention', description: 'Twitter mention', default_unit: 2)
      end

      def down
        Metric.destroy_all
      end
    end
  end
end
