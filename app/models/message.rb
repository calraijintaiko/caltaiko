class Message

  include ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :name, :email, :content, :performance_request

  validates :name, presence: true
  validates :email, presence: true
  validates :content, presence: true

  PERFORMANCE_EMAIL = 'performances@caltaiko.org'
  GENERAL_EMAIL = 'general@caltaiko.org'

  def to_address
    return PERFORMANCE_EMAIL if performance_request
    GENERAL_EMAIL
  end

  def subject
    return "Performance request from #{name}" if performance_request
    "Message from #{name}"
  end
end
