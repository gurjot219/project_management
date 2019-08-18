class InvitationMailer < ApplicationMailer
  default from: "from@example.com"

  def sign_up_email(email, team_id, role)
    @team_name= Team.find(team_id).name
    @email=email
    @team_id=team_id
    @role=role
    mail(to: @email, subject: 'Please set up your account')
  end
end
