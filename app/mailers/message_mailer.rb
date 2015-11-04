class MessageMailer < ApplicationMailer
  default from: 'www.caltaiko.org <caltaiko.website@gmail.com>'
  default to: 'Cal Taiko <general@caltaiko.org>'

  def new_message(message)
    @message = message

    mail subject: @message.subject, to: @message.to_address,
      reply_to: "#{@message.name} <#{@message.email}>"
  end
end
