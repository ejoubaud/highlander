module AchievementCalculators
  module Calculators
    class GreenBuild < Event

      event_calculator!

      private

      def badges
        {
          1    => '1_green_build',
          100  => '100_green_build',
          250  => '250_green_build',
          500  => '500_green_build',
          1000 => '1000_green_build'
        }
      end

      def concerned_with
        'team_city_build_complete'
      end
    end

  end

end
