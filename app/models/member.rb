=begin rdoc
Members have name, gen, major, bio, and avatar fields.
To create a member, all of the fields except the avatar must be present.
* The name must be at least two characters long
* The gen must be an integer greater than 0
* The major must also be at least two characters long
If no avatar is given, an image is provided by http://robohash.org, 
which hashes input to pictures of robots.

Should robohash.org ever close down, there are also regular 
default images available to be used.
They can be found in
    /public/images/:style/missing.png
=end
class Member < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged
  validates :name, presence: true, length: { minimum: 2 }
  validates :gen, presence: true, numericality: {only_integer: true, greater_than: 0 }
  validates :major, presence: true, length: {minimum: 2}
  validates :bio, presence: true

  Paperclip.interpolates :slug do |attachment, style|
    attachment.instance.slug
  end

  has_attached_file :avatar, :styles => { thumb: "500x500#", full: "500x9999" },
  path: "/members/:slug/:attachment/:style/:filename",
  url: "/members/:slug/:attachment/:style/:filename",
  # default_url: "/images/members/:attachment/:style/missing.png"
  # if robohash website ever closes down, delete below and uncomment above
  default_url: "http://robohash.org/:id?size=500x500&bgset=bgany"
  include DeletableAttachment
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  # Generates a unique slug for a new member based on their name.
  # If a member with the same name already exists, adds gen to the end.
  # If a member with the same name and gen already exists, uses unique id.
  def slug_candidates
    [
     :name,
     [:name, :gen],
    ]
  end

  def first_name
    return self.name.split.first
  end

  def last_name
    return self.name.split.last
  end

  # Returns all current members of the team, ordered by name then gen.
  def self.current_members
    return Member.where(current: true).order('name ASC, gen')
  end

  # Returns all alumni of the team, ordered by name then gen.
  def self.alumni
    return Member.where(current: false).order('name ASC, gen')
  end

  # Returns all the members of Generation GEN
  def self.gen(gen)
    return Member.where("gen = ?", gen).order('name ASC')
  end

  # Returns all of the generations
  def self.gens
    return Member.select(:gen).distinct.order('gen ASC')
  end
end
