class MembersController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :index, :current, :alumni]

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
    @current = Member.current_members
    @alumni = Member.alumni
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
    @alumni = Member.alumni
  end

  private
  def set_member
    @member = Member.friendly.find(params[:id])
  end

  def member_params
    params.require(:member).permit(:name, :gen, :major, :bio, :avatar,
                                   :current, :delete_avatar)
  end
end
