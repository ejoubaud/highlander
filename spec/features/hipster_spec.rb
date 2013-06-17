require 'spec_helper'

feature 'Hipster Badge' do

  given(:endpoint) { '/api/twitter_mention.json' }

  background do
    @first_time_badge     = FactoryGirl.create(:first_time)
    @hipster_badge        = FactoryGirl.create(:badge, :hipster)
    @first_tweet          = FactoryGirl.create(:one_twitter_mention)
  end

  given(:user)          { FactoryGirl.create(:user) }
  given(:existing_user) { FactoryGirl.create(:user, name: 'Jane Smith') }
  given(:metric)        { FactoryGirl.create(:twitter_mention) }

  given(:params) do
    {
      metric: metric.name,
      email: user.email
    }
  end

  describe "First tweet - when no other users have that badge yet" do

    background { page.driver.post endpoint, params }

    scenario "User is given the First Tweet, First-time and ONE Hipster badge" do
      visit user_path(user)

      page.should have_content '3 Badges'
      page.should have_content @first_tweet.description
      page.should have_content "#{metric.default_unit} All-time"

      page.should have_content "You unlocked the #{@first_time_badge.description} badge before it was cool"
      page.should_not have_content "You unlocked the #{@first_tweet.description} badge before it was cool"
    end
  end

  describe "First tweet - when another user has the badges already" do

    background do
      page.driver.post endpoint, params.merge(email: existing_user.email)
      page.driver.post endpoint, params.merge(email: user.email)
    end

    scenario "User is given the First Tweet, First-time and NO Hipster badges" do
      visit user_path(user)
      page.should have_content '2 Badges'
      page.should have_content @first_tweet.description
      page.should have_content "#{metric.default_unit} All-time"
      page.should_not have_content @hipster_badge.tag
    end
  end

end
