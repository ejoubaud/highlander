module AchievementCalculators
  module Calculators
    class GreenBuild < Event

      event_calculator!

      private

      def badges
        {
          1    => '1_green_build',
          100  => '100_green_builds',
          250  => '250_green_builds',
          500  => '500_green_builds',
          1000 => '1000_green_builds'
        }
      end

      def concerned_with
        'team_city_build_complete'
      end
    end

  end

end
