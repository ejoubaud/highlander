module Queries

  class BadgesIncludingAchievedGroupedByMetric

    def initialize(relation: Badge.enabled, clan: clan)
      @relation = relation
      @clan = clan
    end

    def each(&block)
      query.each(&block)
    end

    def query
      query = relation
        .select('distinct(badges.*)')
        .joins(:achievements, :users)
        .order('badges.position ASC')
        

      query = query.joins("join kinships on kinships.user_id = users.id").where("kinships.clan_id" => @clan.id) if @clan

      query.group_by { |x| x.related_metric }
    end

    private

    attr_reader :relation, :clan

  end
end
