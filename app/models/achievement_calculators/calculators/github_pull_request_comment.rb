module AchievementCalculators
  module Calculators
    class GithubPullRequestComment < Event

      event_calculator!

      private

      def badges
        {
          1    => '1_github_pr_comment',
          100  => '100_github_pr_comments',
          250  => '250_github_pr_comments',
          500  => '500_github_pr_comments',
          1000 => '1000_github_pr_comments'
        }
      end

      def concerned_with
        'github_pull_request_comment'
      end

    end

  end

end
