module DataMigration
  module MigrationFiles
    class AddMissingRelatedMetrics < Base
      def up
        Badge.where("name like '%pr_comment%'").update_all(related_metric: 'github_pull_request_comment')
        Badge.where("name like '%green_build%'").update_all(related_metric: 'team_city_build_complete')
        Badge.where("name like '%code_quality_improvement%'").update_all(related_metric: 'code_quality_improvement')
      end

      def down
        Badge.where("name like '%pr_comment%'").update_all(related_metric: nil)
        Badge.where("name like '%green_build%'").update_all(related_metric: nil)
        Badge.where("name like '%code_quality_improvement%'").update_all(related_metric: nil)
      end
    end
  end
end