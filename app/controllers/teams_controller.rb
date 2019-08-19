class TeamsController < ApplicationController
  before_action :find_team, only: [:edit, :show, :update, :destroy]

  def index
    if current_user.admin_user?
      @teams= Team.all
    else
      @teams= Team.where(user_id: current_user.id)
    end
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team.user_id = current_user.id if current_user.present?
    if @team.save
      redirect_to teams_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @team.update(team_params)
      redirect_to teams_path
    else
      render 'edit'
    end
  end

  def show
  end


  def destroy
    @team.destroy
    redirect_to teams_path
  end

  def send_invite
    if params[:invitation][:email].present? && params[:invitation][:team_id].present?
      @invite= Invitation.create(email: params[:invitation][:email], role: params[:invitation][:role], team_id: params[:invitation][:team_id], owner_id: current_user.id)
      redirect_to team_path(params[:invitation][:team_id]) if @invite.id.present?
    end
  end

  def invite_sign_up
    if params[:email] && params[:team_id]
      if Invitation.where(email: params[:email], team_id: params[:team_id]).first.user_id.present?
        redirect_to new_user_session_path(email: params[:email])
      else
        redirect_to new_user_registration_path(email: params[:email], team_id: params[:team_id])
      end
    else
      redirect_to team_path(params[:team_id])
    end
  end

  private
  def find_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name, :title)
  end
end
