module PayloadAdapters

  class GithubPush < GithubBase

    def branch
      payload[:ref]
    end

    def github_username
      username = payload[:pusher][:name] rescue nil
      username || payload[:committers].to_a.sort_by(&:last).last.first rescue nil
    end

    def payload=(value)
      super

      # Pushes can be huge, so truncate it to just the author list.

      @payload["committers"] = []
      @payload["committers"] << @payload["head_commit"]["author"]["username"]


      @payload["commits"].collect do |commit|
      	@payload["committers"] << commit['author']['username'] rescue nil
      end

      @payload.delete("commits")
      @payload.delete("head_commit")
      @payload.delete("repository")

      # Tally the committers
      @payload["committers"] = @payload["committers"].inject(Hash.new) do |totals, committer|
      	totals[committer] ||= 0
      	totals[committer] += 1
      	totals
      end
    end

  end

end
