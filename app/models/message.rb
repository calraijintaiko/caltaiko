class Message

  include ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :name, :email, :content, :performance_request

  validates :name, presence: true
  validates :email, presence: true
  validates :content, presence: true

  def to_address
    return 'performances@caltaiko.org' if performance_request
    'general@caltaiko.org'
  end

  def subject
    return "Performance request from #{name}" if performance_request
    "Message from #{name}"
  end

end
