class Member < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 2 }
  validates :gen, presence: true, numericality: {only_integer: true, greater_than: 0 }
  validates :major, presence: true, length: {minimum: 2}
  validates :bio, presence: true

  has_attached_file :avatar, :styles => { thumb: "200x200#" },
  path: ":rails_root/public/system/members/:attachment/:id/:style/:filename",
  url: "/system/members/:attachment/:id/:style/:filename",
  default_url: "/images/:style/missing.png"
  include DeletableAttachment
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

end
