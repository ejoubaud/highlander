class RunIntegrations < Thor

  desc 'run', 'Runs the integrations for all clans'
  def run
    require File.join(File.dirname(__FILE__), '../../config/environment')

    integrations = [
      Integrations::TwitterIntegration, 
      Integrations::PagerDutyIntegration, 
      Integrations::CodeClimateIntegration
    ]

    Clan.find_each do |clan|
      integrations.each do |integration|
        config = clan.get_integration_config(integration)

        if config
          runner = integration.new
          runner.configure(clan, config)
          runner.execute
        end
      end
    end
  end
end