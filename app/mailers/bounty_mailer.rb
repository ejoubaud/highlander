class BountyMailer < ActionMailer::Base

  # TODO: Clan-specific address? Clan admin address?
  DEFAULT_SENDER = "donotreply@hilander.io"

  def new_bounty(creator, clan, bounty)
    @creator = creator
    @clan = clan
    @bounty = bounty

    mail(
      to: @clan.members_emails,
      from: DEFAULT_SENDER,
      subject: "[Hilander] New bounty: #{@bounty.name}"
    )
  end

end
