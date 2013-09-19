module DataMigration
  module MigrationFiles
    class ChangePrLabel < Base
      def up
        Metric.where(name: 'github_pull_request_comment').update_all(description: 'Pull Request Comment')
        Badge.where(name: '1_github_pr_comment').update_all(description: 'First Pull Request Comment')
        Badge.where(name: '100_github_pr_comments').update_all(description: '100 Pull Request Comments')
        Badge.where(name: '250_github_pr_comments').update_all(description: '250 Pull Request Comments')
        Badge.where(name: '500_github_pr_comments').update_all(description: '500 Pull Request Comments')
        Badge.where(name: '1000_github_pr_comments').update_all(description: '1000 Pull Request Comments')
      end

      def down
        Metric.where(name: 'github_pull_request_comment').update_all(description: 'Comment on a Pull Request')
        Badge.where(name: '1_github_pr_comment').update_all(description: 'First Comment on a Pull Request')
        Badge.where(name: '100_github_pr_comments').update_all(description: '100 Comments on a Pull Request')
        Badge.where(name: '250_github_pr_comments').update_all(description: '250 Comments on a Pull Request')
        Badge.where(name: '500_github_pr_comments').update_all(description: '500 Comments on a Pull Request')
        Badge.where(name: '1000_github_pr_comments').update_all(description: '1000 Comments on a Pull Request')
      end
    end
  end
end