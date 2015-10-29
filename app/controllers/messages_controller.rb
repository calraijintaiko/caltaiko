class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)

    if @message.valid?
      MessageMailer.new_message(@message).deliver
      redirect_to contact_path, notice: "Your messages has been sent."
    else
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:name, :email, :content)
  end
end
