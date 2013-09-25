module DataMigration
  module MigrationFiles
    class DowngradePrCommentReward < Base
      def up
        Metric.find_by_name('github_pull_request_comment').update_attributes!(default_unit: 1)
      end

      def down
        Metric.find_by_name('github_pull_request_comment').update_attributes!(default_unit: 2)
      end
    end
  end
end
