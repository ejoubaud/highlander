module DataMigration
  module MigrationFiles
    class AddDeployBadge < Base

      def up
        Metric.create!(name: 'deploy', description: 'Deploys')
        Badge.create!(name: '1_deploy', tag: 'Deploy novice', description: 'First Deploy', related_metric: "deploy")
        Badge.create!(name: '15_deploys', tag: 'Ohh, you\'re good at this', description: '15 Deploys', related_metric: "deploy")
        Badge.create!(name: '30_deploys', tag: 'Trigger Happy', description: '30 Deploys', related_metric: "deploy")
        Badge.create!(name: '45_deploys', tag: 'Deployinator', description: '45 Deploys', related_metric: "deploy")
        Badge.create!(name: '60_deploys', tag: 'Deploy Immortal', description: '60 Deploys', related_metric: "deploy")
      end

      def down
        Badge.where(name: "1_deploy").destroy_all
        Badge.where(name: "15_deploys").destroy_all
        Badge.where(name: "30_deploys").destroy_all
        Badge.where(name: "45_deploys").destroy_all
        Badge.where(name: "60_deploys").destroy_all
        
        metric = Metric.where(name: "deploy")
        Event.where(metric_id: metric).destroy_all
        metric.destroy_all
      end
    end
  end
end
