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
end
