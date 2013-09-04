module DataMigration
  module MigrationFiles
    class MigrateIntoClans < Base

      def up
        if User.count > 0
          clan = Clan.create!(name: "Macleods", slug: "macleods")
          User.all.each do |user|
            kinship = Kinship.create!(clan: clan, user: user, role: user.role)
            Achievement.where(user_id: user.id).update_all(kinship_id: kinship.id)
            Event.where(user_id: user.id).update_all(kinship_id: kinship.id)
          end

          Bounty.update_all(clan_id: clan.id)
        end
      end

      def down
        Clan.delete_all
        Kinship.delete_all
        Achievement.update_all(kinship_id: nil)
        Event.update_all(kinship_id: nil)
        Bounty.update_all(clan_id: nil)
      end
    end
  end
end
