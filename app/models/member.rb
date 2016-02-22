# == Schema Information
#
# Table name: members
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  bio                 :text
#  created_at          :datetime
#  updated_at          :datetime
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  gen                 :integer
#  major               :string(255)
#  current             :boolean
#  slug                :string(255)
#  email               :string(255)
#
# To create a member, all of the fields except the avatar must be present.
# * The name must be at least two characters long
# * The gen must be an integer greater than 0
# * The major must also be at least two characters long
# If no avatar is given, an image is provided by http://robohash.org,
# which hashes input to pictures of robots.
#
# Should robohash.org ever close down, there are also regular
# default images available to be used.
# They can be found in
#     /public/images/:style/missing.png
class Member < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  validates :name, presence: true, length: { minimum: 2 }
  validates :gen, presence: true,
                  numericality: { only_integer: true, greater_than: 0 }
  validates :major, presence: true, length: { minimum: 2 }
  validates :bio, presence: true
  validates :email, format: { with: /(\A.+@\w+\.\w+\z)|(\A\z)/,
                              message: 'Please enter a valid email address.' }

  Paperclip.interpolates :slug do |attachment, _style|
    attachment.instance.slug
  end

  # rubocop:disable Style/AlignHash
  has_attached_file :avatar, styles: { thumb: '500x500#', full: '500x9999' },
    path: '/members/:slug/:attachment/:style/:filename',
    url: '/members/:slug/:attachment/:style/:filename',
    # default_url: '/images/members/:attachment/:style/missing.png'
    # if robohash website ever closes down, delete below and uncomment above
    default_url: 'https://robohash.org/:id?size=500x500&bgset=bgany',
    s3_protocol: :https
  # rubocop:enable Style/AlignHash
  include DeletableAttachment
  validates_attachment_content_type :avatar, content_type: %r{\Aimage/.*\Z}

  # Generates a unique slug for a new member based on their name.
  # If a member with the same name already exists, adds gen to the end.
  # If a member with the same name and gen already exists, uses unique id.
  def slug_candidates
    [
      :name,
      [:name, :gen]
    ]
  end

  # Return the first name of the member
  def first_name
    name.split.first
  end

  # Return the last name of the member
  def last_name
    name.split.last
  end

  # Returns all current members of the team, ordered by name then gen.
  def self.current_members
    Member.where(current: true).order('name ASC, gen')
  end

  # Returns all alumni of the team, ordered by name then gen.
  def self.alumni
    Member.where(current: false).order('name ASC, gen')
  end

  # Returns all the members of Generation GEN
  def self.gen(gen)
    Member.where('gen = ?', gen).order('name ASC')
  end

  # Returns all of the generations
  def self.gens
    Member.select(:gen).distinct.order('gen ASC')
  end
end
