module AchievementCalculators
  module Calculators

    class Deploy < Event

      event_calculator!

      private

      def badges
        {
          1   => '1_deploy',
          10  => '10_deploys',
          25  => '25_deploys',
          50  => '50_deploys',
          100 => '100_deploys'
        }
      end

    end

  end
end

