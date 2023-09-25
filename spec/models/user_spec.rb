require 'rails_helper'

RSpec.describe User, type: :model do
  context 'is valid' do
    it 'with factory' do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end
  end

  context 'is not valid' do
    it 'without email' do
      user = FactoryBot.build(:user, email: nil)
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to eq(["Email can't be blank"])
    end

    it 'without password' do
      user = FactoryBot.build(:user, password: nil)
      expect(user).to_not be_valid
      expect(user.errors.full_messages).to eq(["Password can't be blank"])
    end

    it 'if email is not unique' do
      commited_user = FactoryBot.create(:user)
      registering_user = FactoryBot.build(:user, email: commited_user.email)
      expect(registering_user).to_not be_valid
      expect(registering_user.errors.full_messages).to eq(["Email has already been taken"])
    end
  end

  it 'generates a reset token' do
    user = FactoryBot.create(:user)
    user.generate_reset_token
    expect(user.reset_token).to match(/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/)
  end

  it 'reset token expires in 30 minutes' do
    predicted_expiry_time = DateTime.now + 30.minutes
    user = FactoryBot.create(:user)
    user.generate_reset_token
    expect(user.reset_token_expiry.round(0)).to eq(predicted_expiry_time.utc.round(0))
  end
  
  it 'reset token is invalid after expiry time' do
    user = FactoryBot.create(:user)
    user.generate_reset_token
    user.reset_token_expiry = (DateTime.now - 30.minutes).utc
    expect(user.is_reset_token_valid?).to be(false)
  end

  it 'reset token is valid before expiry time' do
    user = FactoryBot.create(:user)
    user.generate_reset_token
    expect(user.is_reset_token_valid?).to be(true)
  end
end
