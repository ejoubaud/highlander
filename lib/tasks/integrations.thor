class Integrations < Thor

  desc 'poll', 'Runs the integrations for all clans'
  def poll
    require File.join(File.dirname(__FILE__), '../../config/environment')

    integrations = [
      ::Integrations::TwitterIntegration, 
      ::Integrations::PagerDutyIntegration, 
      ::Integrations::CodeClimateIntegration
    ]

    Clan.find_each do |clan|
      integrations.each do |integration|
        config = clan.get_integration_config(integration)

        if config
          runner = integration.new
          runner.configure(clan, config)

          begin
            runner.execute
            Rails.logger.info("Completed running #{integration} for clan_id: #{clan.id}")
          rescue Object => ex
            Rails.logger.error("Error running #{integration} for clan_id #{clan.id}: #{ex.class.name} - #{ex.message}")
            Rails.logger.error(ex.backtrace)
          end
        end
      end
    end
  end
end