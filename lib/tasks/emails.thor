class Emails < Thor

  desc 'bounties', 'Sends an email about new bounties created in the last 15 minutes'
  def bounties
    require File.join(File.dirname(__FILE__), '../../config/environment')

    Bounty.where('created_at > ?', Time.now - 10.minutes).group_by(&:clan_id).each do |clan_id, bounties|     
      clan = Clan.find(clan_id)
      Rails.logger.debug("Clan##{clan_id} has #{bounties.length} bounties to send")

      clan.users.where(send_bounties: true).each do |user|
        begin
          UserMailer.new_bounties(user, bounties).deliver!
        rescue => ex
          Rails.logger.error("Error sending bounty email to User##{user.id}")
          Rails.logger.error(ex.message)
          Rails.logger.error(ex.backtrace)
        end
      end
    end

    Rails.logger.debug("Bounties sent!")
  end

  
  desc 'leaderboard', 'Sends the leaderboard to all clan members for each clan'
  def leaderboard
    return unless Time.now.utc.wday == 5 # Only on fridays.
    require File.join(File.dirname(__FILE__), '../../config/environment')

    Clan.find_each do |clan|
      Rails.logger.debug("Sending leaderboard for Clan##{clan.id}")
      clan.users.where(send_leaderboard: true).each do |user|
        begin
          UserMailer.leaderboard(user, clan).deliver!
        rescue => ex
          Rails.logger.error("Error sending leaderboard email to User##{user.id}")
          Rails.logger.error(ex.message)
          Rails.logger.error(ex.backtrace)
        end
      end
    end

    Rails.logger.debug("Leaderboards sent!")
  end
end

