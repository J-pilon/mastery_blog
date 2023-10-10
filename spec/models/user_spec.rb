require 'rails_helper'

RSpec.describe User, type: :model do
  let(:invalid_token_time_limit) { DateTime.now }
  let(:valid_token_time_limit) { DateTime.now + 1.second }

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

  context 'when reset token' do
    let(:user) { FactoryBot.create(:user) }

    it 'is generated' do
      user.generate_reset_token
      expect(user.reset_token).to match(/^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/)
    end
  
    # it 'expires after time limit' do
    #   user.generate_reset_token
    #   expect(user.reset_token_expiry).to be_within(1.second).of(invalid_token_time_limit.utc)
    # end
  end
    
  context 'when reset token is valid' do
    let(:user) { FactoryBot.create(:user) }

    it 'before expiry time' do
      user = FactoryBot.create(:user)
      user.generate_reset_token
      user.reset_token_expiry = valid_token_time_limit
      expect(user.is_reset_token_valid?).to be(true)
    end
  
    it 'if tokens match' do
      user.generate_reset_token
      expect(user.is_reset_token_valid?).to be(true)
    end
  end

  context 'when reset token is invalid' do
    let(:user) { FactoryBot.create(:user) }

    it 'after expiry time' do
      user = FactoryBot.create(:user)
      user.generate_reset_token
      user.reset_token_expiry = invalid_token_time_limit.utc
      expect(user.is_reset_token_valid?).to be(false)
    end
  end
end
