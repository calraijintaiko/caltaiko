class MessageMailer < ApplicationMailer
  default from: 'www.caltaiko.org <caltaiko.website@gmail.com>'
  default to: 'Cal Taiko <general@caltaiko.org>'

  def new_message(message)
    @message = message

    mail subject: "Message from #{@message.name}",
      reply_to: "#{message.name} <#{@message.email}>"
  end
end
