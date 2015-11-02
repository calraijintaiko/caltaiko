require 'rails_helper'

RSpec.describe Message, type: :model do
  it 'has a valid factory' do
    expect(build(:message)).to be_valid
  end

  it 'is invalid without a name' do
    expect(build(:message, name: nil)).to_not be_valid
  end

  it 'is invalid without an email' do
    expect(build(:message, email: nil)).to_not be_valid
  end

  it 'is invalid without any content' do
    expect(build(:message, content: nil)).to_not be_valid
  end

  context 'for a performance request' do
    let(:message) { build(:performance_request) }

    it 'has the performances email address set as the to-address' do
      expect(message.to_address).to eql Message::PERFORMANCE_EMAIL
    end

    it 'mentions a performance request in the subject' do
      expect(message.subject).to eql "Performance request from #{message.name}"
    end
  end

  context 'for a general message' do
    let(:message) { build(:general_message) }

    it 'has the general email address set as the to-address' do
      expect(message.to_address).to eql Message::GENERAL_EMAIL
    end

    it 'does not mention a performance request in the subject' do
      expect(message.subject).to eql "Message from #{message.name}"
    end
  end
end
