class Invitation < ApplicationRecord
  belongs_to :team

  after_create do
    InvitationMailer.sign_up_email(self.email, self.team_id, self.role).deliver
  end
end
