class Emails < Thor

  desc 'bounties', 'Sends an email about new bounties created in the last 15 minutes'
  def bounties
    require File.join(File.dirname(__FILE__), '../../config/environment')

    Bounty.where('created_at > ?', Time.now - 10.minutes).group_by(&:clan_id).each do |clan_id, bounties|
      clan = Clan.find(clan_id)

      clan.users.where(send_bounties: true).each do |user|
        begin
          UserMailer.new_bounties(user, bounties).deliver!
        rescue
        end
      end
    end
  end

  
  desc 'leaderboard', 'Sends the leaderboard to all clan members for each clan'
  def leaderboard
    return unless Time.now.utc.wday == 5 # Only on fridays.
    require File.join(File.dirname(__FILE__), '../../config/environment')

    Clan.find_each do |clan|
      clan.users.where(send_leaderboard: true).each do |user|
        begin
          UserMailer.leaderboard(user, clan).deliver!
        rescue
        end
      end
    end
  end
end

