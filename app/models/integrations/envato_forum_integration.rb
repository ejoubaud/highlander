module Integrations
  class EnvatoForumIntegration < Base

    def execute
      current_clan.users.with_service(:envato).each do |user|
        username = user.service_for(:envato).try(:username)
        query = Event.forum_posts.where(user: user)

        posts_for(username).each do |post|
          post_metric(:forum_post, post_id: post.post_id, username: username) \
            unless query.with_key_and_value(:post_id => post.post_id).any?
        end
      end
    end

    def posts_for envato_username
      repsonse = RestClient.get "http://marketplace.envato.com/api/edge/user:#{envato_username}.json"
      JSON.parse repsonse
    end
  end
end
