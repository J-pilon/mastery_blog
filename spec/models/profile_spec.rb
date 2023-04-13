require 'rails_helper'

RSpec.describe Profile, type: :model do
  context 'is valid' do
    it 'with factory' do
      profile = FactoryBot.build(:profile)
      expect(profile).to be_valid
    end
  end

  context 'is not valid' do
    it 'without first name' do
      profile = FactoryBot.build(:profile, first_name: nil)
      expect(profile).to_not be_valid
      # expect(profile.errors.full_messages).to eq(["First name can't be blank"])
    end

    it 'without last name' do
      profile = FactoryBot.build(:profile, last_name: nil)
      expect(profile).to_not be_valid
      expect(profile.errors.full_messages).to eq(["Last name can't be blank"])
    end
  end
end
