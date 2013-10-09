require 'spec_helper'

feature 'Github Issue Opened' do

  given(:endpoint) { "http://clan.#{SITE_ROOT}/api/github_issue_opened.json" }

  background do
    @first_time_badge                         = FactoryGirl.create(:first_time)
    @one_github_issue_opened_badge            = FactoryGirl.create(:one_github_issue_opened)
    @twenty_five_github_issues_opened_badge   = FactoryGirl.create(:twenty_five_github_issues_opened)
  end

  given!(:user)           { FactoryGirl.create(:user, :githubber) }
  given!(:clan)           { FactoryGirl.create(:clan, slug: 'clan', users: [user]) }
  given!(:github_service) { user.service_for(:github) }
  given!(:metric)         { FactoryGirl.create(:github_issue_opened) }

  given(:github_payload) { GithubPayloads.issue_opened(github_service.username) }

  describe 'First opened issue' do

    background { page.driver.post endpoint, payload: github_payload }

    scenario 'User is given the First Github Issue Opened and First Timer badges' do
      visit user_path(user)
      page.should have_content @first_time_badge.description
      page.should have_content @one_github_issue_opened_badge.description # failing because badge is missing

      page.should have_content "#{metric.default_unit} All-time"
      page.should have_content '2 badges'
    end
  end

end
