require 'spec_helper'

describe Clan do
  describe '#members_emails' do
    let(:user1) { FactoryGirl.create(:user, :primary_email => 'user1@test.io') }
    let(:user2) { FactoryGirl.create(:user, :primary_email => 'user2@test.io') }
    subject(:clan) { FactoryGirl.create(:clan, :users => [user1, user2]) }

    it 'returns a list of email addresses for all the clan members' do
      results = clan.members_emails

      results.count.should == 2
      results.should include('user1@test.io')
      results.should include('user2@test.io')
    end
  end
end
