module DataMigration
  module MigrationFiles
    class ForumPostBadge < Base

      def up
        Metric.create!(name: 'forum_post', description: 'Posted in our forums', default_unit: 2)
        Badge.create!(name: '1_forum_post', tag: 'Did you check your spelling?', description: 'First Forum Post')
        Badge.create!(name: '50_forum_posts', tag: 'Post dabbler', description: '50 Forum Posts')
        Badge.create!(name: '100_forum_posts', tag: 'Postaholic', description: '100 Forum Posts')
        Badge.create!(name: '250_forum_posts', tag: 'Bringing the Post-Apolocalypse', description: '250 Forum Posts')
        Badge.create!(name: '500_forum_posts', tag: 'Sheesh, is there an election on or something?', description: '500 Forum Posts')
      end

      def down
        Metric.find_by_name('forum_post').destroy
        Badge.where(name: "1_forum_post").destroy
        Badge.where(name: "100_forum_posts").destroy
        Badge.where(name: "250_forum_posts").destroy
        Badge.where(name: "500_forum_posts").destroy
        Badge.where(name: "1000_forum_posts").destroy
      end
    end
  end
end
