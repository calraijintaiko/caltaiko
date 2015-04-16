# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  username               :string(255)
#

# Users are the accounts that can be used to add and edit members and
# performances. Both a username and email address are required when creating a
# new account, and both must be unique (ie we can't use caltaiko@gmail.com for
# every account.
#
# Account settings (username, email, password) can be easily modified by logging
# in then going to <tt>localhost:3000/settings</tt>
# === Note:
# After deployment, the +registerable+ tag will be removed, so that someone
# couldn't just create an account.
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # +login+ is used to authenticate users when logging in.
  # It can be either a username or a password.
  attr_accessor :login

  # This method was originally defined by the Devise gem.
  # It is overwritten here to allow the use of either username or email
  # for login (default is only email)
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    # Note: the use of assignment (=) rather than comparison (==) is intentional
    # rubocop:disable Lint/AssignmentInCondition, Rails/FindBy
    if login = conditions.delete(:login)
      where(conditions).where(['lower(username) = :val OR lower(email) = :val',
                               { val: login.downcase }]).first
    else
      where(conditions).first
    end
    # rubocop:enable Lint/AssignmentInCondition, Rails/FindBy
  end

  validates :username, presence: true, uniqueness: { case_sensitive: false }
end
