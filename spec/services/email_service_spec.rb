require 'rails_helper'

RSpec.describe 'EmailService' do
  let(:user) { FactoryBot.create(:user) }
  let(:client) { Aws::SES::Client.new(region: 'us-east-2', stub_responses: true) }
  let(:email_contents) do
    {
      subject: 'subject',
      html_body: 'body',
      encoding: 'UTF-8'
    }
  end
  let(:valid_email_service) do
    EmailService.new(client: client,
                     user: user,
                     contents: email_contents)
  end

  it 'responds to send!' do
    expect(valid_email_service.respond_to?(:send!)).to be(true)
  end

  context 'when valid' do
    it 'returns a message id' do
      resp = valid_email_service.send!
      expect(resp.message_id).to eq('MessageId')
    end
  end
end
