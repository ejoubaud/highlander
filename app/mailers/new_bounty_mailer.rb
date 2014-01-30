class NewBountyMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "email"

  def notify_user(user, bounties)
	@bounties = bounties
	@clan = bounties.first.clan
	mail to: user.email, subject: "New bounties offered!"  	
  end
end
