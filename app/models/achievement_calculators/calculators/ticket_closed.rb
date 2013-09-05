module AchievementCalculators
  module Calculators
    class TicketClosed < Event

      event_calculator!

      private

      def badges
        {
          1    => '1_lighthouse_ticket_closed'
          100  => '100_lighthouse_ticket_closed',
          250  => '250_lighthouse_ticket_closed',
          500  => '500_lighthouse_ticket_closed',
          1000 => '1000_lighthouse_ticket_closed'
        }
      end

      def concerned_with
        'lighthouse_ticket_closed'
      end
    end

  end

end
