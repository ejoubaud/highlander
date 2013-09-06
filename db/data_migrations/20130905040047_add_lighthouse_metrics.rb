module DataMigration
  module MigrationFiles
    class AddLighthouseMetrics < Base

      def up
        Metric.create!(name: 'lighthouse_ticket_closed', default_unit: 5, description: 'Closed Lighthouse Ticket')
        Badge.create!(name: '1_lighthouse_ticket_closed', tag: 'Well done, sir', description: 'First Ticket Closed')
        Badge.create!(name: '100_lighthouse_tickets_closed', tag: 'Ticket centurion', description: '100 Tickets Closed')
        Badge.create!(name: '250_lighthouse_tickets_closed', tag: 'Lighthouse Abuser', description: '250 Tickets Closed')
        Badge.create!(name: '500_lighthouse_tickets_closed', tag: 'Ticket Slayer', description: '500 Tickets Closed')
        Badge.create!(name: '1000_lighthouse_tickets_closed', tag: 'GODLIKE Ticket Solver', description: '1000 Tickets Closed')
      end

      def down
        Metric.find_by_name('lighthouse_ticket_closed').destroy
        Badge.where(name: "1_lighthouse_ticket_closed").destroy
        Badge.where(name: "100_lighthouse_tickets_closed").destroy
        Badge.where(name: "250_lighthouse_tickets_closed").destroy
        Badge.where(name: "500_lighthouse_tickets_closed").destroy
        Badge.where(name: "1000_lighthouse_tickets_closed").destroy
      end
    end
  end
end
