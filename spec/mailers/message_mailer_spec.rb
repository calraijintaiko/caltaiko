require "rails_helper"

RSpec.describe MessageMailer, type: :mailer do
  describe 'new_message' do
    let(:message) { build :message }
    let(:mail) { MessageMailer.new_message(message) }

    it 'renders the subject' do
      expect(mail.subject).to eql message.subject
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql [message.to_address]
    end

    it 'renders the reply-to email' do
      expect(mail.reply_to).to eql [message.email]
    end

    it 'renders the sender email' do
      expect(mail.from).to eql ['caltaiko.website@gmail.com']
    end

    it 'assigns @content' do
      expect(mail.body.encoded.strip).to end_with message.content
    end

    it "starts the content with the sender's name and email" do
      message_intro = "#{message.name} (#{message.email}) wrote:"
      expect(mail.body.encoded).to start_with message_intro
    end
  end
end
