module Queries

  class UsersWithBadge

    def initialize(badge: badge, clan: clan)
      @badge = badge
      @clan = clan
    end

    def each(&block)
      query.each(&block)
    end

    def query
     query = badge
      .achievements
      .order('achievements.created_at ASC')

      query = query.joins("join kinships on kinships.id = achievements.kinship_id").where("kinships.clan_id" => @clan.id) if @clan

      query.map { |x| User.unscoped { x.user.decorate } }
    end

    private

    attr_reader :badge, :clan

  end
end
