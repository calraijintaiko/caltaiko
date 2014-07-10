class MembersController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :index]

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(member_params)
 
    if @member.save
      redirect_to @member
    else
      render 'new'
    end
  end

  def index
    @members = Member.all
  end

  def show
    set_member
  end

  def edit
    set_member
  end

  def update
    set_member

    if @member.update(member_params)
      redirect_to @member
    else
      render 'edit'
    end
  end

  def destroy
    set_member
    @member.destroy
    
    redirect_to members_path
  end

  def current
    @current = Member.current_members
  end

  def alumni
    @alumni = Performance.alumni_members
  end

  private
  def set_member
    @member = Member.find(params[:id])
  end

  def member_params
    params.require(:member).permit(:name, :gen, :major, :bio, :avatar, :current)
  end
end
