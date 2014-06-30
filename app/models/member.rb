class Member < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 2 }
  validates :gen, presence: true, numericality: {only_integer: true, greater_than: 0 }
  validates :major, presence: true, length: {minimum: 2}
  validates :bio, presence: true
  # validates :avatar, attachment_presence: true
  # validates_with AttachmentPresenceValidator, :attributes => :avatar

  # attr_accessor :avatar_file_name
  # attr_accessor :avatar_content_type

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
