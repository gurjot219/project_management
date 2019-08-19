class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attr_reader :team_id
  ROLES= %w(admin manager developer)

  before_create do
    invitation= Invitation.where(email: self.email, team_id: self.team_id).first
    self.role = invitation.role if invitation.present?
  end

  after_create do
    invitation= Invitation.where(email: self.email, team_id: self.team_id).first
    invitation.update(user_id: self.id) if invitation.present?
  end

  def admin_user?
    role == 'admin' ? true: false
  end
end
