module DataMigration
  module MigrationFiles
    class AddGithubPullRequestComment < Base
      def up
        Metric.create!(name: 'github_pull_request_comment', description: 'Comment on a Pull Request', default_unit: 2)
        Badge.create!(name: '1_github_pr_comment', tag: 'Just being curious?', description: 'First Comment on a Pull Request')
        Badge.create!(name: '100_github_pr_comments', tag: 'Experienced Reviewer', description: '100 Comments on a Pull Request')
        Badge.create!(name: '250_github_pr_comments', tag: 'Code Watcher', description: '250 Comments on a Pull Request')
        Badge.create!(name: '500_github_pr_comments', tag: 'Code Quality Supervisor', description: '500 Comments on a Pull Request')
        Badge.create!(name: '1000_github_pr_comments', tag: 'Code Review Maniac', description: '1000 Comments on a Pull Request')
      end

      def down
        Metric.find_by_name('github_pull_request_comment').destroy
        Badge.where(name: "1_github_pr_comment").destroy
        Badge.where(name: "100_github_pr_comments").destroy
        Badge.where(name: "250_github_pr_comments").destroy
        Badge.where(name: "500_github_pr_comments").destroy
        Badge.where(name: "1000_github_pr_comments").destroy
      end
    end
  end
end
