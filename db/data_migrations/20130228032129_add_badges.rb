module DataMigration
  module MigrationFiles
    class AddBadges < Base

      def up
        Badge.create!(name: 'first_time', tag: 'Experience the quickening', description: 'First timer')

        Badge.create!(name: '1_twitter_mention', related_metric: 'twitter_mention', tag: 'Fly fly little birdie!', description: 'First Twitter mention')
        Badge.create!(name: '25_twitter_mentions', related_metric: 'twitter_mention', tag: 'In a flutter', description: '25 Twitter mentions')
        Badge.create!(name: '50_twitter_mentions', related_metric: 'twitter_mention', tag: 'Swoop in for the kill', description: '50 Twitter Mentions')
      end

      def down
        Badge.destroy_all
      end
    end
  end
end
