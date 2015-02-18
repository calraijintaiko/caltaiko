# Controller for members resource. Handles what information is sent to the
# views, as well as creation and updating of members.
class MembersController < ApplicationController
  before_action :authenticate_user!,
                except: [:show, :index, :current, :alumni, :gen, :all_gens]
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  # Create a blank member to be used by form.
  def new
    @member = Member.new
  end

  # Push a new member to the database with inputted parameters.
  # If saved successfully redirects to show member, otherwise back to form.
  def create
    @member = Member.new(member_params)

    if @member.save
      redirect_to @member
    else
      render 'new'
    end
  end

  # Default method for members. Gives all current members and alumni.
  def index
    @current = Member.current_members
    @alumni = Member.alumni
    @gens = Member.gens
  end

  # Give member whose ID or slug matches request.
  def show
  end

  # Give member whose ID or slug matches request, to be used by form.
  def edit
  end

  # Find member whose ID or slug matches request, then update parameters
  # to new inputted values. If updates successfully redirects to show member,
  # otherwise back to edit form.
  def update
    if @member.update(member_params)
      redirect_to @member
    else
      render 'edit'
    end
  end

  # Erase member from database, then redirect to index page.
  def destroy
    @member.destroy

    redirect_to members_path
  end

  # Gives all current members, as received from Member model.
  def current
    @current = Member.current_members
    @gens = Member.gens
  end

  # Gives all alumni, as received from Member model.
  def alumni
    @alumni = Member.alumni
    @gens = Member.gens
  end

  # Gives all members of inputted gen, or returns to index if input invalid.
  def gen
    @gen = params[:gen]
    if @gen.to_i <= 0
      redirect_to members_path
    else
      @members = Member.gen(@gen)
    end
  end

  def all_gens
    @gens = Member.gens
  end

  def database
    @current = Member.current_members
    @alumni = Member.alumni
  end

  private

  def set_member
    @member = Member.friendly.find(params[:id])
  end

  def member_params
    params.require(:member).permit(:name, :email, :gen, :major, :bio, :avatar,
                                   :current, :delete_avatar)
  end
end
