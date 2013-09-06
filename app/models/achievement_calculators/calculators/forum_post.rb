module AchievementCalculators
  module Calculators

    class ForumPost < Event

      event_calculator!

      private

      def badges
        {
          1   => '1_forum_post',
          10  => '10_forum_posts',
          25  => '25_forum_posts',
          50  => '50_forum_posts',
          100 => '100_forum_posts'
        }
      end

    end

  end
end
