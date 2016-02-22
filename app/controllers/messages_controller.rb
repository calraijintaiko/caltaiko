class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)

    if @message.valid?
      begin
        MessageMailer.new_message(@message).deliver_now
        redirect_to contact_path, notice: "Your messages has been sent."
      rescue
        flash[:alert] = 'An error occured and your message could not be sent'\
          '; please email us directly at caltaiko@gmail.com'
        render :new
      end
    else
      flash[:alert] = 'Please fill out every field in the contact form, and '\
        'check to ensure the email address entered is valid.'
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:name, :email, :content,
                                    :performance_request)
  end
end
