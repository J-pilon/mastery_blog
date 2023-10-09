require 'rails_helper'

RSpec.describe "EmailService" do
  let(:user) { FactoryBot.create(:user) }
  let(:client) { Aws::SES::Client.new(region: "awsregion", stub_responses: true) }
  let(:email_type) { "password_reset_email" }
  let(:valid_email_service) do 
    EmailService.new(client: client, 
                      user: user, 
                      contents: I18n.t(:password_reset_email))
  end

  it "responds to send!" do 
    expect(valid_email_service.respond_to?(:send!)).to be(true)
  end

  context 'when valid' do
    it "returns a message id" do
      expect(valid_email_service.send!).to eq({message_id: "MessageId"})
    end
  end
end